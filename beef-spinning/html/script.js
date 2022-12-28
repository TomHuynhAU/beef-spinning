const startButton = document.querySelector("#start");
const itemList = document.querySelector("#item-list");
let isRunning = false;
let itemMap = [];
let config = {};

const timePed = 100;

const resetMap = () => {
	itemList.innerHTML = "";
	for (let i = 0; i < 25; i++) {
	  const newDom = document.createElement("div");
	  newDom.className = "item";
	  newDom.innerHTML = `<img src="img/qmark-01.png" alt="weapon"/>`;
	  itemList.appendChild(newDom);
	}
}

// initial
resetMap();

startButton.onclick = async () => {
  if (isRunning) return;
  isRunning = true;
  // requesting for data
  const icons = config.data.map(item => item.weapon || item.item);
  const specialItemRaw = config.data.find(x => x.special == 1);
  const specialItem = specialItemRaw.item || specialItemRaw.weapon;

  const response = await $.post("http://beef-spinning/getResult");
  if (!response) {
	  isRunning = false;
	  return Swal.fire(
		'Thất bại',
		`Bạn không đủ hòm quay rồi...`,
		'error'
	  )
  }
  const returnItem = response.item;
  const remainingTurns = response.remaining;
  $('.remaining').text(remainingTurns + " lượt quay còn lại | F8 nhập: lagquayhom //nếu bạn bị lag hòm quay");
  const result = {
	item: returnItem.item,
	label: returnItem.label,
	isSpecial: returnItem.item === config.special
  };
  
  // main processing
  itemList.innerHTML = '';
  itemMap = [];
  var obj = document.createElement("audio");
  obj.src = "mohom.mp3";
  obj.volume = 0.3;
  obj.play(); 

  // preparing the appearance
  for (let i = 0; i < 25; i++) {
	let item = config.special;
	while (item === config.special) {
	  item = icons[~~(Math.random() * icons.length)];
	}
    itemMap.push(item);
  }
  if (!itemMap.includes(result.item)) replaceRandomItem(result.item);
  if (!result.special) {
	replaceRandomItem(specialItem);
  } else {
	let replacedIndex = getRandomIndex(itemMap);
	while (itemMap[replacedIndex] === result.item) {
		replacedIndex = getRandomIndex(itemMap);
	}
	itemMap[replacedIndex] = specialItem;
  }
  
  const specialIndex = itemMap.findIndex(x => x === specialItem);

  // bind appearance
  itemMap.forEach(item => {
    const newDom = document.createElement("div");
    newDom.className = "item";
    newDom.setAttribute("item", item);
    newDom.innerHTML = `<img src="nui://ox_inventory/web/images/${item}.png" alt="weapon"/>`;
    itemList.appendChild(newDom);
  });
  itemList.querySelectorAll('.item')[specialIndex].classList.add("special");

  // animation
  let lastItem = null;
  for (let i = 0; i < 45; i++) {
    await new Promise(_ => setTimeout(_, timePed + i > 45 ? i * 10 : 0));
    if (lastItem) lastItem.classList.remove("current");
    let allCurrentItems = itemList.querySelectorAll(".item");
    let currentItem = allCurrentItems[~~(Math.random() * allCurrentItems.length)];
    currentItem.classList.add("current");
    lastItem = currentItem;
  }
  await new Promise(_ => setTimeout(_, 1000));
  // finishing
  if (result.isSpecial) {
    lastItem.classList.remove("current");
    itemList.querySelector(`.item.special`).classList.add("current");
  } else {
    lastItem.classList.remove("current");
    let indexesOfType = [];
    itemMap.forEach((item, index) => {
      if (item === result.item) indexesOfType.push(index);
    })
    let randIndex = indexesOfType[~~(Math.random() * indexesOfType.length)];
    itemList.querySelectorAll(".item")[randIndex].classList.add("current");
  }
  await new Promise(_ => setTimeout(_, 2000));
  isRunning = false;
  var obj = document.createElement("audio");
  obj.src = "win.mp3";
  obj.volume = 0.3;
  obj.play(); 
  Swal.fire(
	'Chúc mừng',
	`🎉Bạn đã trúng ${result.label}`,
	'success'
  )
  resetMap();
};

const replaceRandomItem = (newItem) => itemMap[~~(Math.random() * itemMap.length)] = newItem;
const calcItem = (array, requiredItem) => {
  let total = 0;
  array.forEach(i => total+= i === requiredItem ? 1 : 0);
  return total;
}
const getRandom = (array) => {
  return array[~~(Math.random() * array.length)];
}
const getRandomIndex = (array) => {
  return ~~(Math.random() * array.length);
}
window.addEventListener("message", t => {
	const message = t.data;
	if (message.type === "ui") {
		config = message;
		$('.name').text(message.name);
		$('.remaining').text(message.remaining + " lượt quay còn lại | F8 nhập: lagquayhom //nếu bạn bị lag hòm quay");
		$(document.body).show();
  } else {
    $(document.body).hide('slow');
	}
	$(document).keyup(function(e) {
		if (e.key === "Escape" && !isRunning) { // escape key maps to keycode `27`
			$(document.body).hide('slow');
			$.post("http://beef-spinning/esc");
		}
	});
});

let toggle = true;
$('.credit a').click(e => {
	$('.credit a').text(toggle ? 'fb.me/monokaijssss' : 'MonokaiJs');
	toggle = !toggle;
})
