import { GameItem } from '../model/GameItem'
import { routePageNoParams } from '../util/NavigationUtil'

@Entry
@Component
struct Index {
  private gameList: GameItem[] = [
    { title: 'Simon Says', url: 'pages/SimonSaysPage' },
    { title: 'Number Recall', url: 'pages/NumberRecallPage' },
    { title: 'Fast Math', url: 'pages/FastMathPage' }
  ]

  build() {
    Column() {
      Text('Memory Trainer')
        .fontSize(18)
        .fontWeight(FontWeight.Bold)
        .margin({ bottom: 4 })

      ForEach(this.gameList, (item: GameItem) => {
        Button(item.title)
          .fontSize(14)
          .margin({ top: 4 })
          .borderRadius(17)
          .onClick(() => {
            routePageNoParams(item.url)
          })
      }, (item: GameItem) => item.title)
    }
    .alignItems(HorizontalAlign.Center)
    .justifyContent(FlexAlign.Center)
    .height('100%')
    .width('100%')
  }
}
