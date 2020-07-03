using Toybox.WatchUi as Ui;
using Toybox.Graphics as Gfx;
using Toybox.System as Sys;

class ArenaView extends Ui.View {
    var arena;
    var snake; 
    function initialize() {
        View.initialize();
        arena = new Arena();
        snake = new Snake();
    }

    function onUpdate(dc) {
       	dc.setColor(Gfx.COLOR_BLACK, Gfx.COLOR_WHITE);
        dc.clear();

        dc.setPenWidth(5);

        //drawPerimeter(dc);
        //drawFood(dc);
        //drawSnake(dc);
    }
    
    function drawPerimeter(dc) {
        dc.drawRectangle(
            (arena.screenWidth - arena.width) / 2,
            (arena.screenHeight - arena.height) / 2,
            arena.width,
            arena.height
        );
    }
    
    function drawSnake(dc) {
        for (var i = 0; i < snake.size; i++) {
            dc.drawPoint(
                snake.xCoordinates[i],
                snake.yCoordinates[i]
            );
        }
    }

    function drawFood(dc) {
        Ui.requestUpdate();
        dc.drawPoint(arena.foodX, arena.foodY);
    }

}


function getArenaView() {
    var view = new ArenaView();
    var delegate = new ArenaDelegate(view);
    Ui.pushView(
        view,
        delegate,
        Ui.SLIDE_IMMEDIATE
    );
}


