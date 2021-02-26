
function open_gender_tile(event)
{

    if (event.data.gender == "male") {

        $("#male_body_tile").show()
        $("#female_body_tile").hide()

    } else {

        $("#male_body_tile").hide()
        $("#female_body_tile").show()

    }

}

function hide_tiles()
{

    $("#panel_tiles").hide()

}

function open_panel(event)
{

    open_gender_tile(event)

}

function nui_event(event)
{
    if (event.data.type == "open_panel") {

        gender = event.data.gender
        open_panel(event)

    }
}

function keyboard_handler() 
{
    switch (event.key) {

        case "Escape":
            hide_tiles()
            $.post("http://car-fob/EscapeCarFob", JSON.stringify({}))
            break;

    }
}



$(function() 
{

    open_gender_tile({"data":{"gender":"male"}})
    window.addEventListener('message', nui_event);
    window.addEventListener('keydown', keyboard_handler)

})