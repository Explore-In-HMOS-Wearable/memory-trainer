import { FastMathViewModel } from '../viewmodel/FastMathViewModel'

@Component
export struct FastMathPage {
  @Consume('pageStack') pageStack: NavPathStack;

  @State private viewModel: FastMathViewModel = new FastMathViewModel(
    () => {
      this.feedbackMessage = '✅ Correct!'
      setTimeout(() => {
        this.feedbackMessage = ''
        this.viewModel.generateQuestion()
      }, 1000)
    },
    () => {
      this.feedbackMessage = '❌ Wrong! Restarting...'
      setTimeout(() => {
        this.feedbackMessage = ''
        this.viewModel.generateQuestion()
      }, 1000)
    }
  )

  @State private feedbackMessage: string = ''

  @Builder
  renderAnswerButtons(): void {
    Column({ space: 4 }) {
      ForEach(this.viewModel.options, (option: number) => {
        Button(option.toString())
          .fontSize(15)
          .width(100)
          .height(24)
          .onClick(() => {
            this.viewModel.submitAnswer(option)
          })
      }, (option: number) => option.toString())
    }
  }


  build() {
    NavDestination() {
      Column() {
        Row() {
          Button() {
            SymbolGlyph($r('sys.symbol.arrow_left'))
          }
          .height(27)
          .width(27)
          .onClick(() => {
            this.pageStack.pop()
          })

          Text('Fast Math')
            .fontSize(12)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 5 })
        }
        .alignItems(VerticalAlign.Center)

        if (this.feedbackMessage !== '') {
          Text(this.feedbackMessage)
            .fontSize(13)
            .fontColor(Color.Black)
            .fontColor(Color.Gray)
            .margin({ bottom: 5 })
        }

        Text(this.viewModel.question)
          .fontSize(22)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Medium)
          .margin({ bottom: 2 })

        this.renderAnswerButtons()
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .padding({ top: 20, bottom: 20 })
      .height('100%')
      .width('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }
}