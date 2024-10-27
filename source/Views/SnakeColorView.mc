using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;
using Toybox.Application as App;

class SnakeColorView extends ArenaView{
    var colorIndex;
    var colors;
    var count;
    var label;
    
    function initialize() {
        ArenaView.initialize();
        configArenaPerimeter();
        snake = new Snake(10, $.center + 25, 140);
        colorIndex = App.getApp().getProperty("snakeColor");
        count = -1;
    }

    function onUpdate(dc) {
        clearScreenAndConfig(dc);
        drawSnake(dc);
        configLabel();
        drawText(dc);
        drawBar(dc);
    }

    function driver() {
        var nextCoordinate = snake.getNextPlot();
        snake.moveForward(nextCoordinate[x], nextCoordinate[y]);
        $.crayon.configColors();

        if (count == 10 || count == -1) {
            snake.setDirection(1);
            count = 0;
        }

        count += 1;
        Ui.requestUpdate();
    }
    function drawBar(dc) {
        for (var i = 0; i < $.crayon.colors.size(); i ++) {
            var focus = 0;
            var y = (($.screenHeight / 3) * 2) + 15;
            if (colorIndex == i) {
                focus = 10;
                y -= 5;
            }
            
            dc.setColor($.crayon.colors[i], Gfx.COLOR_TRANSPARENT);
            dc.fillRectangle(
                $.screenWidth / 3 + (10 * i),
                y,
                10,
                10 + focus               
            );
        }
    }
    function drawText(dc) {
        dc.setColor(foregroundColor, Gfx.COLOR_TRANSPARENT);
        var x = $.screenWidth / 2; 
        var y = $.screenHeight / 2; 
        dc.drawText(
            x,
            y,
            Gfx.FONT_MEDIUM,
            label,
            Gfx.TEXT_JUSTIFY_CENTER
        );
    }
    function configSnakeColor() {
        Sys.println("hre");
        snakeColor = $.crayon.colors[colorIndex];
    }
    function configLabel() {
        if (colorIndex == 0) {
            label = "Green";
        } else if (colorIndex == 1) {
            label = "Blue";
        } else if (colorIndex == 2) {
            label = "Pink";
        } else if (colorIndex == 3) {
            label = "Yellow";
        } else if (colorIndex == 4) {
            label = "Orange";
        } else if (colorIndex == 5) {
            label = "Gray";
        } else if (colorIndex == 6) {
            label = "Red";
        } else if (colorIndex == 7) {
            label = "System";
        } else if (colorIndex == 8) {
            label = "Rainbow";
        }
    }

    // function drawPerimeter() {
    //     return true;
    // }

    function changeColor(val) {
        colorIndex = (colorIndex + val) % ($.crayon.colors.size());
        if (colorIndex < 0) {
            colorIndex = $.crayon.colors.size() - 1;
        }
    }

    function configDifficulty() {
		timer.start(method(:driver), 100, true); 
    }

    function configArenaPerimeter() {
        arena.northWall = 0;
        arena.westWall = 0;
        arena.eastWall = 600;
        arena.southWall = 600;
    }

    function setColor() {
        App.getApp().setProperty("snakeColor", colorIndex);
    }
}

class SnakecolorDelegate extends Ui.BehaviorDelegate {
    var view;
    
    function initialize(view) {
        BehaviorDelegate.initialize();
        self.view = view;
    }

    function onSelect() {
        view.setColor();
        Ui.popView(Ui.SLIDE_IMMEDIATE);
        return true;
    }

    function onNextPage() {
        view.changeColor(1);
        return true;
    }
    function onPreviousPage() {
        view.changeColor(-1);
        return true;
    }

}

function getSnakeColorView() {
    var view = new SnakeColorView();
    var delegate = new SnakecolorDelegate(view);
    Ui.pushView(
        view,
        delegate,
        Ui.SLIDE_IMMEDIATE
    );
}
