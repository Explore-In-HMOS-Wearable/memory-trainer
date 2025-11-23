export class FastMathViewModel {
  question: string = ''
  correctAnswer: number = 0
  options: number[] = []

  onSuccess: () => void
  onFailure: () => void

  private counter: number = Date.now()

  constructor(onSuccess: () => void, onFailure: () => void) {
    this.onSuccess = onSuccess
    this.onFailure = onFailure
    this.generateQuestion()
  }

  private nextRand(max: number): number {
    this.counter = (this.counter * 1103515245 + 12345) & 0x7fffffff
    return (this.counter % max)
  }

  generateQuestion() {
    const a = this.nextRand(10) + 1
    const b = this.nextRand(10) + 1
    const isAddition = this.nextRand(2) === 1

    this.correctAnswer = isAddition ? a + b : a - b
    this.question = `${a} ${isAddition ? '+' : '-'} ${b}`

    const fake1 = this.correctAnswer + (this.nextRand(3) + 1)
    const fake2 = this.correctAnswer - (this.nextRand(3) + 2)

    let options = [this.correctAnswer, fake1, fake2]

    for (let i = 0; i < options.length; i++) {
      const j = this.nextRand(options.length)
      let temp = options[i]
      options[i] = options[j]
      options[j] = temp
    }

    this.options = options
  }

  submitAnswer(answer: number) {
    if (answer === this.correctAnswer) {
      this.onSuccess()
    } else {
      this.onFailure()
    }
  }
}
