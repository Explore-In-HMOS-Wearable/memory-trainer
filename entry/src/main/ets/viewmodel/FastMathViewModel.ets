export class FastMathViewModel {
  question: string = ''
  correctAnswer: number = 0
  options: number[] = []

  onSuccess: () => void
  onFailure: () => void

  constructor(onSuccess: () => void, onFailure: () => void) {
    this.onSuccess = onSuccess
    this.onFailure = onFailure
    this.generateQuestion()
  }

  generateQuestion() {
    const a = Math.floor(Math.random() * 10) + 1
    const b = Math.floor(Math.random() * 10) + 1
    const isAddition = Math.random() > 0.5

    this.correctAnswer = isAddition ? a + b : a - b
    this.question = `${a} ${isAddition ? '+' : '-'} ${b}`

    const fake1 = this.correctAnswer + (Math.random() < 0.5 ? -1 : 1) * (Math.floor(Math.random() * 3) + 1)
    const fake2 = this.correctAnswer + (Math.random() < 0.5 ? -1 : 1) * (Math.floor(Math.random() * 3) + 2)

    this.options = [this.correctAnswer, fake1, fake2].sort(() => Math.random() - 0.5)
  }

  submitAnswer(answer: number) {
    if (answer === this.correctAnswer) {
      this.onSuccess()
    } else {
      this.onFailure()
    }
  }
}
