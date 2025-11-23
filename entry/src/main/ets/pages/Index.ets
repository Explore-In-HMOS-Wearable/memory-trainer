import { FastMathPage } from './FastMathPage';
import { HomePage } from './HomePage';
import { NumberRecallPage } from './NumberRecallPage';
import { SimonSaysPage } from './SimonSaysPage';

@Entry
@Component
struct Index {
  @Provide('pageStack') pageStack: NavPathStack = new NavPathStack();

  @Builder
  Pages(name: string) {
    if (name === 'HomePage') {
      HomePage();
    } else if (name === 'FastMathPage') {
      FastMathPage();
    } else if (name === 'NumberRecallPage') {
      NumberRecallPage();
    } else if (name === 'SimonSaysPage') {
      SimonSaysPage();
    }
  }

  build() {
    Navigation(this.pageStack)
      .mode(NavigationMode.Stack)
      .navDestination(this.Pages)
      .hideNavBar(true)
      .onAppear(() => {
        if (this.pageStack.getAllPathName().length === 0) {
          this.pageStack.pushPathByName('HomePage', null);
        }
      })
  }
}