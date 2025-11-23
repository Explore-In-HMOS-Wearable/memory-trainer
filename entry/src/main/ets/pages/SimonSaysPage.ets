import { SimonSaysViewModel } from '../viewmodel/SimonSaysViewModel'
import { promptAction } from '@kit.ArkUI'
import { SimonColor } from '../model/SimonColor'

@Component
export struct SimonSaysPage {
  @Consume('pageStack') pageStack: NavPathStack;

  @State private viewModel: SimonSaysViewModel = new SimonSaysViewModel(
    () => {
      promptAction.showToast({ message: '✅ Correct! Advancing to next level...' })
      setTimeout(() => {
        this.viewModel.nextRound()
        this.showSequence()
      }, 800)
    },
    () => {
      promptAction.showToast({ message: '❌ Wrong! Restarting the game.' })
      setTimeout(() => {
        this.viewModel.resetGame()
        this.showSequence()
      }, 800)
    }
  )
  @State private currentShowIndex: number = -1

  @Builder
  renderButton(color: SimonColor): void {
    Button('')
      .backgroundColor(color)
      .margin(4)
      .height(60)
      .width(60)
      .borderRadius(30)
      .scale(
        (this.currentShowIndex !== -1 &&
          this.viewModel.sequence[this.currentShowIndex] === color) ?
          { x: 1.2, y: 1.2 } :
          { x: 1.0, y: 1.0 }
      )
      .onClick(() => {
        if (!this.viewModel.isShowingSequence) {
          this.viewModel.handleUserInput(color)
        }
      })
  }

  aboutToAppear() {
    this.showSequence()
  }

  build() {
    NavDestination() {
      Column() {
        Row() {

          Button() {
            Image($r('app.media.ic_arrow_left'))
              .foregroundColor(Color.Black)
          }
          .height(17)
          .width(17)
          .onClick(() => {
            this.pageStack.pop()
          })

          Text('Simon Says')
            .fontColor(Color.Black)
            .fontSize(12)
            .fontWeight(FontWeight.Bold)
            .margin({ left: 5 })
        }
        .alignItems(VerticalAlign.Center)
        .margin({ bottom: 5 })

        Grid() {
          this.renderButton(SimonColor.RED)
          this.renderButton(SimonColor.GREEN)
          this.renderButton(SimonColor.BLUE)
          this.renderButton(SimonColor.YELLOW)
        }
        .columnsTemplate('1fr 1fr')
        .rowsTemplate('1fr 1fr')
        .height(117)
        .width(117)

        Blank()
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.SpaceBetween)
      .height('100%')
      .width('100%')
      .padding({ top: 20, bottom: 20 })
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
    .hideBackButton(true)
  }

  showSequence() {
    this.viewModel.isShowingSequence = true
    let i = 0

    const intervalId = setInterval(() => {
      this.currentShowIndex = i

      setTimeout(() => {
        this.currentShowIndex = -1
      }, 250)

      i++
      if (i >= this.viewModel.sequence.length) {
        clearInterval(intervalId)
        this.viewModel.isShowingSequence = false
      }
    }, 580)
  }
}
