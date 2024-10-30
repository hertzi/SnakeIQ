using Toybox.WatchUi as Ui;
using Toybox.System as Sys;
using Toybox.Application as App;

class SnakeIQMenuDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :newGame) {
            getArenaView();
        
        } else if (item == :settings) {
            getSettingsMenu();

        } else if (item == :highScores) {
            var view = new HighScoreView();
            WatchUi.pushView(view, new HighScoreDelegate(view), WatchUi.SLIDE_UP);
        }
    }

    function getSettingsMenu() {
        var view = new Rez.Menus.SettingsMenu();
        if(Sys.getDeviceSettings().isTouchScreen) {
            view.addItem("Control", :control);
        }
        var delegate = new SnakeIQSettingsDelegate(); 
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_UP);
    }

    function getHighScoreMenu() {
        var view = new HighScoreView();
        var delegate = new HighScoreDelegate(view);
        WatchUi.pushView(view, delegate, WatchUi.SLIDE_UP);
    }
    

}

class SnakeIQSettingsDelegate extends Ui.MenuInputDelegate {

    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :darkMode) {
            getDarkModeMenu();

        } else if (item == :snakeColor) {
            getSnakeColorView();

        } else if (item == :difficulty) {
            getDifficultyMenu();

        } else if (item == :control) {
            getControlMenu();
        }
    }

}

function getDarkModeMenu() {
    var menu = new Ui.Menu();
    var darkMode = App.getApp().getProperty("darkMode");
    menu.setTitle("DarkMode");
    if (!darkMode) {
        menu.addItem("Enable", :enable); 
    } else {
        menu.addItem("disable", :disable); 
    }

    Ui.pushView(
        menu,
        new DarkModeSettingsDelegate(),
        Ui.SLIDE_IMMEDIATE
    );
}

function getSnakeColorMenu() {
    var menu = new Ui.Menu();
    menu.setTitle("Snake Color");
    menu.addItem("Green", :green); 
    menu.addItem("Blue", :blue); 
    menu.addItem("Pink", :pink); 
    menu.addItem("Yellow", :yellow); 
    menu.addItem("Orange", :range); 
    menu.addItem("Gray", :gray); 
    menu.addItem("Black", :black); 
    menu.addItem("Red", :red); 


    Ui.pushView(
        menu,
        new SnakeColorSettingsDelegate(),
        Ui.SLIDE_IMMEDIATE
    );
}

function getDifficultyMenu() {
    var menu = new Ui.Menu();
    menu.setTitle("Difficulty");
    menu.addItem("Easy", :easy); 
    menu.addItem("Medium", :kindaEasy); 
    menu.addItem("Expert", :normal); 


    Ui.pushView(
        menu,
        new DifficultySettingsDelegate(),
        Ui.SLIDE_IMMEDIATE
    );
}

function getControlMenu() {
    var menu = new Ui.Menu();
    menu.setTitle("Control");
    menu.addItem("Button", :button); 
    menu.addItem("TouchScreen", :touch); 

    Ui.pushView(
        menu,
        new ControlSettingsDelegate(),
        Ui.SLIDE_IMMEDIATE
    );
}

class SnakeColorSettingsDelegate extends Ui.MenuInputDelegate {
    var colorIndex;
    function initialize() {
        MenuInputDelegate.initialize();
        var colorIndex = 0;
    }

    function onMenuItem(item) {
        if (item == :Green) {
            colorIndex = 0;
        } else if (item == :blue) {
            colorIndex = 1;
        } else if (item == :pink) {
            colorIndex = 2;
        } else if (item == :yellow) {
            colorIndex = 3;
        } else if (item == :range) {
            colorIndex = 4;
        } else if (item == :gray) {
            colorIndex = 5;
        } else if (item == :black) {
            colorIndex = 6;
        } else if (item == :red) {
            colorIndex = 7;
        } 

        App.getApp().setProperty("snakeColor", colorIndex);
    }
}

class DarkModeSettingsDelegate extends Ui.MenuInputDelegate {
    
    function initialize() {
        MenuInputDelegate.initialize();
    }

    function onMenuItem(item) {
        if (item == :disable) {
            App.getApp().setProperty("darkMode", false);
        
        } else if (item == :enable) {
            App.getApp().setProperty("darkMode", true);
        }

        $.crayon.configDarkMode();
        $.crayon.configColors();
    }
}

class DifficultySettingsDelegate extends Ui.MenuInputDelegate {
    var difficulty;
    function initialize() {
        MenuInputDelegate.initialize();
        difficulty = expert;
    }

    function onMenuItem(item) {
        if (item == :normal) {
            difficulty = expert;
        } else if (item == :kindaEasy) {
            difficulty = medium;
        } else if (item == :easy) {
            difficulty = easy;
        } 

        App.getApp().setProperty("difficulty", difficulty);
    }
}

class ControlSettingsDelegate extends Ui.MenuInputDelegate {
    var control;
    function initialize() {
        MenuInputDelegate.initialize();
        control = button;
    }

    function onMenuItem(item) {
        if (item == :button) {
            control = button;
        } else if (item == :touch) {
            control = touch;
        } 
        App.getApp().setProperty("control", control);
    }
}
