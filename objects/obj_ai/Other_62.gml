show_debug_message("Async event triggered. ID: " + string(async_load[? "id"]));
if (async_load[? "id"] == request_id) {
    show_debug_message("Full async_load: " + json_stringify(async_load));
    
    if (async_load[? "status"] < 0) {
        show_debug_message("Error occurred: " + async_load[? "error"]);
        text = "Error: " + async_load[? "error"];
    } else {
        text = handle_text_generation_response(async_load);
        show_debug_message("Generated text: " + text);
		alarm[1] = 120
    }
    
    show_debug_message("HTTP Status: " + string(async_load[? "http_status"]));
    show_debug_message("Response headers: " + json_stringify(async_load[? "response_headers"]));
    ds_list_add(cleanup_list, request_id);
    alarm[0] = 2;
}
