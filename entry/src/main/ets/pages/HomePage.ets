import { GameItem } from '../model/GameItem'

@Component
export struct HomePage {
  @Consume('pageStack') pageStack: NavPathStack;

  private gameList: GameItem[] = [
    { title: 'Simon Says', url: 'SimonSaysPage' },
    { title: 'Number Recall', url: 'NumberRecallPage' },
    { title: 'Fast Math', url: 'FastMathPage' }
  ]

  build() {
    NavDestination() {
      Column() {
        Text('Memory Trainer')
          .fontSize(18)
          .fontColor(Color.Black)
          .fontWeight(FontWeight.Bold)
          .margin({ bottom: 4 })

        ForEach(this.gameList, (item: GameItem) => {
          Button(item.title)
            .fontSize(14)
            .margin({ top: 4 })
            .borderRadius(17)
            .onClick(() => {
              this.pageStack.pushPathByName(item.url, null);
            })
        }, (item: GameItem) => item.title)
      }
      .alignItems(HorizontalAlign.Center)
      .justifyContent(FlexAlign.Center)
      .height('100%')
      .width('100%')
    }.onReady((ctx: NavDestinationContext) => {
      this.pageStack = ctx.pathStack;
    })
  }
}
