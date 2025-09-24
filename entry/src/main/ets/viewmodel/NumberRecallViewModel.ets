export class NumberRecallViewModel {
  sequence: number[] = []
  userInput: string = ''
  showSequence: boolean = true

  onSuccess: () => void
  onFailure: () => void

  constructor(onSuccess: () => void, onFailure: () => void) {
    this.onSuccess = onSuccess
    this.onFailure = onFailure
    this.resetGame()
  }

  resetGame() {
    this.sequence = []
    this.userInput = ''
    this.addDigit()
    this.showSequence = true
  }

  addDigit() {
    const randomDigit = Math.floor(Math.random() * 10)
    this.sequence.push(randomDigit)
  }

  submitAnswer() {
    if (this.userInput === this.sequence.join('')) {
      this.onSuccess()
    } else {
      this.onFailure()
    }
  }
}
