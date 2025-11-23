import { SimonColor } from '../model/SimonColor'
import { cryptoFramework } from '@kit.CryptoArchitectureKit'

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

  async  addRandomColor() {
    const colors = Object.values(SimonColor)
    const randomIndex = await SecureRandom.randomInt(colors.length);
    const randomColor = colors[randomIndex] as SimonColor;
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

export class SecureRandom {
  static async randomInt(max: number): Promise<number> {
    try {
      const rand = cryptoFramework.createRandom();
      const dataBlob = await rand.generateRandom(4);

      const bytes = dataBlob.data;

      const value = (bytes[0] << 24) | (bytes[1] << 16) | (bytes[2] << 8) | bytes[3];

      const unsignedValue = value >>> 0;

      return unsignedValue % max;
    } catch (err) {
      throw new Error('Random number error');
    }
  }
}