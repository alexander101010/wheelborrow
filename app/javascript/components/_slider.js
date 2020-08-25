
const sliderAnimation = () =>{
  const value = document.querySelector('#slider_value')
  value.innerText = 50
  50
  const slider = document.querySelector('#tool_price')
  slider.addEventListener('mousemove', event => {
    let sliderValue = event.currentTarget.value
    value.innerText = "€" + sliderValue
  })
};

export { sliderAnimation };
