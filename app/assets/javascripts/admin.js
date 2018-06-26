document.addEventListener('turbolinks:load', () => {
	dates = document.getElementsByClassName('date')

	for (let i = 0; i < dates.length; i++) {
		dates[i].addEventListener('click', selectDate)
	}
})

function selectDate(e) {
	const day = e.currentTarget.innerText
	const span = document.getElementsByTagName('span')
	const active = document.getElementsByClassName(day)
	console.log(day)


	for (let i = 0; i < span.length; i++) {
		span[i].style.display = 'none'
	}

	for (let i = 0; i < active.length; i++) {
		active[i].style.display = 'inline'
	}
}
