/*
 * Copyright (c) 2022 Huawei Device Co., Ltd.
 * Licensed under the Apache License,Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 * http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

export interface NavItem {
  icon: Resource;
  icon_selected: Resource;
  text: Resource;
  id: number;

}

// tabId
export enum TabId {
  HOME,
  QA,
  MENU
}

export const NavList: NavItem[] = [
  {
    icon: $r('app.media.home_normal'),
    icon_selected: $r('app.media.home_sel'),
    text: $r('app.string.tab_home'),
    id: TabId.HOME
  },
  {
    icon: $r('app.media.qa_normal'),
    icon_selected: $r('app.media.qa_sel'),
    text: $r('app.string.tab_qa'),
    id: TabId.QA
  },
  {
    icon: $r('app.media.menu_normal'),
    icon_selected: $r('app.media.menu_sel'),
    text: $r('app.string.tab_menu'),
    id: TabId.MENU
  },
]