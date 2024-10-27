    // Start of Selection
    function handle_text_generation_response(async_load) {
        var generated_text = "Error: Unknown";
        var max_retries = 3;

        if (!variable_global_exists("retry_count")) {
            globalvar retry_count;
            retry_count = 0;
        }

        if (async_load[? "status"] == 0) {
            var response = async_load[? "result"];
            show_debug_message("Raw response: " + string(response));
            
            if (is_string(response)) {
                try {
                    var json_response = json_parse(response);
                    show_debug_message("Parsed JSON: " + json_stringify(json_response));
                    
                    if (is_array(json_response) && array_length(json_response) > 0 && is_struct(json_response[0]) && variable_struct_exists(json_response[0], "generated_text")) {
                        generated_text = json_response[0].generated_text;
                        if (generated_text == "") {
                            if (retry_count < max_retries) {
                                retry_count += 1;
                                show_debug_message("Empty response received. Retrying... Attempt " + string(retry_count));
                                generate_text(context, 0.7);
                                generated_text = "Retrying...";
                            } else {
                                generated_text = "Error: API returned an empty response after " + string(max_retries) + " attempts.";
                                show_debug_message(generated_text);
                            }
                        }
                    } else {
                        generated_text = "Error: Unexpected response format";
                        show_debug_message("Unexpected response format: " + json_stringify(json_response));
                    }
                } catch (e) {
                    generated_text = "Error: API request failed. Please try again.";
                    show_debug_message("API Error: " + string(e));
                    show_debug_message("Response causing error: " + string(response));
                }
            } else {
                generated_text = "Error: Response is not a string";
                show_debug_message("Response type: " + typeof(response));
                show_debug_message("Response content: " + string(response));
            }
        } else {
            generated_text = "Error: HTTP status " + string(async_load[? "http_status"]);
            show_debug_message("HTTP Error: " + string(async_load[? "http_status"]));
            show_debug_message("Full async_load: " + json_stringify(async_load));
        }

        return generated_text;
    }
