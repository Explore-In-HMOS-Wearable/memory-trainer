import { SecureRandom } from './SimonSaysViewModel'

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

  async addDigit() {
    const randomIndex = await SecureRandom.randomInt(10);
    this.sequence.push(randomIndex)
  }

  submitAnswer() {
    if (this.userInput === this.sequence.join('')) {
      this.onSuccess()
    } else {
      this.onFailure()
    }
  }
}
