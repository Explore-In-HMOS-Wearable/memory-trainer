import { NumberRecallViewModel } from '../viewmodel/NumberRecallViewModel'

@Component
export struct NumberRecallPage {
  @Consume('pageStack') pageStack: NavPathStack;
  @State private feedbackMessage: string = ''
  @State private viewModel: NumberRecallViewModel = new NumberRecallViewModel(
    () => {
      this.feedbackMessage = '✅ Correct!'
      setTimeout(() => {
        this.feedbackMessage = ''
        this.viewModel.addDigit()
        this.viewModel.userInput = ''
        this.viewModel.showSequence = true
        this.startSequenceTimer()
      }, 1000)
    },
    () => {
      this.feedbackMessage = '❌ Wrong! Restarting...'
      setTimeout(() => {
        this.feedbackMessage = ''
        this.viewModel.resetGame()
        this.startSequenceTimer()
      }, 1000)
    }
  )

  startSequenceTimer() {
    setTimeout(() => {
      this.viewModel.showSequence = false
    }, 2000)
  }

  aboutToAppear() {
    this.startSequenceTimer()
  }

  build() {
    NavDestination() {
      Column() {
        Row() {

          Button() {
            Image($r('app.media.ic_arrow_left'))
          }
          .height(17)
          .width(17)
          .onClick(() => {
            this.pageStack.pop()
          })

          Text('Number Recall')
            .fontSize(12)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 5 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 5 })

        if (this.feedbackMessage !== '') {
          Text(this.feedbackMessage)
            .fontSize(13)
            .fontColor(Color.Gray)
            .margin({ bottom: 5 })
        }

        if (this.viewModel.showSequence) {
          Text(this.viewModel.sequence.join(''))
            .fontSize(23)
            .fontColor(Color.Black)
            .fontWeight(FontWeight.Medium)
            .margin({ bottom: 10 })
        } else {
          Column() {
            TextInput({ placeholder: 'Enter number' })
              .width(100)
              .fontColor(Color.Black)
              .backgroundColor(Color.Grey)
              .fontSize(17)
              .textAlign(TextAlign.Center)
              .onChange((value: string) => {
                this.viewModel.userInput = value
              })
              .margin({ bottom: 10 })

            Button('Submit')
              .fontSize(13)
              .margin({ top: 3 })
              .onClick(() => {
                this.viewModel.submitAnswer()
              })
          }
        }
        Blank()
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