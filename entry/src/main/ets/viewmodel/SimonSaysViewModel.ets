import { SimonColor } from '../model/SimonColor'

export class SimonSaysViewModel {
  sequence: SimonColor[] = []
  userInput: SimonColor[] = []
  currentStep: number = 0
  isShowingSequence: boolean = false
  onSuccess: () => void
  onFailure: () => void

  constructor(onSuccess: () => void, onFailure: () => void) {
    this.onSuccess = onSuccess
    this.onFailure = onFailure
    this.resetGame()
  }

  resetGame() {
    this.sequence = []
    this.userInput = []
    this.currentStep = 0
    this.addRandomColor()
  }

  addRandomColor() {
    const colors = Object.values(SimonColor)
    const randomColor = colors[Math.floor(Math.random() * colors.length)] as SimonColor
    this.sequence.push(randomColor)
    this.currentStep = 0
    this.isShowingSequence = true
  }

  handleUserInput(color: SimonColor) {
    if (this.isShowingSequence) {
      return
    }

    this.userInput.push(color)
    const index = this.userInput.length - 1

    if (this.userInput[index] !== this.sequence[index]) {
      this.onFailure()
    } else if (this.userInput.length === this.sequence.length) {
      this.onSuccess()
    }
  }

  nextRound() {
    this.userInput = []
    this.addRandomColor()
  }
}