-- Example file with lots of options.
-- You can test with with this command:
-- cd ./etc && ../src/termit --init ../doc/rc.lua.example

require("termit.colormaps")
require("termit.utils")

defaults = {}
defaults.windowTitle = 'Termit'
defaults.startMaximized = false
defaults.hideTitlebarWhenMaximized = false
defaults.tabName = 'Terminal'
defaults.encoding = 'UTF-8'
defaults.wordCharExceptions = '- .,_/'
defaults.font = 'Monospace 12'
defaults.foregroundColor = '#ebdbb2'
defaults.backgroundColor = '#282828'
--default.colormap ='282828,928374,cc241d,fb4934,98971a,b8bb26,d79921,fabd2f,458588,83a598,b16286,d3869b,689d6a,8ec07c,a89984,ebdbb2'
	-- black
--defaults.color0 = '#282828'
--defaults.color8 = '#928374'
	-- red
--defaults.color1 = '#cc241d'
--defaults.color9 = '#fb4934'
	-- green
--defaults.color2 = '#98971a'
--defaults.color10 = '#b8bb26'
	-- yellow
--defaults.color3 = '#d79921'
--defaults.color11 = '#fabd2f'
	-- blue
--defaults.color4 = '#458588'
--defaults.color12 = '#83a598'
	-- magenta
--defaults.color5 = '#b16286'
--defaults.color13 = '#d3869b'
	-- cyan
--defaults.color6 = '#689d6a'
--defaults.color14 = '#8ec07c'
	-- white
--defaults.color7 = '#a89984'
--defaults.color15 = '#ebdbb2'

defaults.showScrollbar = false
defaults.hideSingleTab = true
defaults.hideTabbar = true
defaults.showBorder = true
defaults.hideMenubar = true
defaults.fillTabbar = false
defaults.scrollbackLines = 4096
defaults.geometry = '1x1'
defaults.allowChangingTitle = true
defaults.backspaceBinding = 'AsciiBksp'
defaults.deleteBinding = 'AsciiDel'
defaults.cursorBlinkMode = 'BlinkOff'
defaults.cursorShape = 'Ibeam'
defaults.tabPos = 'Right'
defaults.setStatusbar = function (tabInd)
    tab = tabs[tabInd]
    if tab then
        return tab.encoding..'  Bksp: '..tab.backspaceBinding..'  Del: '..tab.deleteBinding
    end
    return ''
end
defaults.colormap = termit.colormaps.delicate
defaults.matches = {['http[^ ]+'] = function (url) print('Matching url: '..url) end}
defaults.tabs = {{title = 'Test new tab 1'; workingDir = '~'}};
--   {title = 'Test new tab 2'; workingDir = '/tmp'}}
setOptions(defaults)

bindKey('Ctrl-Page_Up', prevTab)
bindKey('Ctrl-Page_Down', nextTab)
bindKey('Ctrl-F', findDlg)
bindKey('Ctrl-2', function () print('Hello2!') end)
bindKey('Ctrl-3', function () print('Hello3!') end)
bindKey('Ctrl-3', nil) -- remove previous binding

-- don't close tab with Ctrl-w, use CtrlShift-w
bindKey('Ctrl-w', nil)
bindKey('CtrlShift-w', closeTab)

setKbPolicy('keycode')

bindMouse('DoubleClick', openTab)

-- 
userMenu = {}
table.insert(userMenu, {name='Close tab', action=closeTab})
table.insert(userMenu, {name='New tab name', action=function () setTabTitle('New tab name') end})

mi = {}
mi.name = 'Zsh tab'
mi.action = function ()
    tabInfo = {}
    tabInfo.title = 'Zsh tab'
    tabInfo.command = 'zsh'
    tabInfo.encoding = 'UTF-8'
    tabInfo.workingDir = '~'
    tabInfo.backspaceBinding = 'AsciiBksp'
    tabInfo.deleteBinding = 'EraseDel'
    openTab(tabInfo)
end
table.insert(userMenu, mi)

table.insert(userMenu, {name='set red color', action=function () setTabForegroundColor('red') end})
table.insert(userMenu, {name='Reconfigure', action=reconfigure, accel='Ctrl-r'})
table.insert(userMenu, {name='Selection', action=function () print(selection()) end})
table.insert(userMenu, {name='dumpAllRows', action=function () forEachRow(print) end})
table.insert(userMenu, {name='dumpVisibleRowsToFile',
    action=function () termit.utils.dumpToFile(forEachVisibleRow, '/tmp/termit.dump') end})
table.insert(userMenu, {name='findNext', action=findNext, accel='Alt-n'})
table.insert(userMenu, {name='findPrev', action=findPrev, accel='Alt-p'})
table.insert(userMenu, {name='new colormap', action=function () setColormap(termit.colormaps.mikado) end})
table.insert(userMenu, {name='toggle menubar', action=function () toggleMenubar() end})
table.insert(userMenu, {name='toggle tabbar', action=function () toggleTabbar()  end})

mi = {}
mi.name = 'Get tab info'
mi.action = function ()
    tab = tabs[currentTabIndex()]
    if tab then
        termit.utils.printTable(tab, '  ')
    end
end
table.insert(userMenu, mi)

function changeTabFontSize(delta)
    tab = tabs[currentTabIndex()]
    setTabFont(string.sub(tab.font, 1, string.find(tab.font, '%d+$') - 1)..(tab.fontSize + delta))
end

table.insert(userMenu, {name='Increase font size', action=function () changeTabFontSize(1) end})
table.insert(userMenu, {name='Decrease font size', action=function () changeTabFontSize(-1) end})
table.insert(userMenu, {name='feed example', action=function () feed('example') end})
table.insert(userMenu, {name='feedChild example', action=function () feedChild('date\n') end})
table.insert(userMenu, {name='move tab left', action=function () setTabPos(currentTabIndex() - 1) end})
table.insert(userMenu, {name='move tab right', action=function () setTabPos(currentTabIndex() + 1) end})
table.insert(userMenu, {name='User quit', action=quit})

addMenu(userMenu, "User menu")
addPopupMenu(userMenu, "User menu")

addMenu(termit.utils.encMenu(), "Encodings")
addPopupMenu(termit.utils.encMenu(), "Encodings")

