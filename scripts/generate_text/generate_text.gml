function generate_text(prompt, temperature = 0.7) {
    var url = "https://api-inference.huggingface.co/models/mistralai/Mistral-Nemo-Instruct-2407"
    var payload = {
	   "inputs": prompt,
        "parameters": {
            "temperature": temperature,
            "max_new_tokens": int64(64), 
            "return_full_text": true
        },
        "options": {
            "use_cache": false
        }
    };
    var payload_string = json_stringify(payload);
    
    var headers = ds_map_create();
	
    ds_map_add(headers, "Authorization", "Bearer YOUR_HUGGING_FACE_KEY");
    ds_map_add(headers, "Content-Type", "application/json");

    var buffer_payload = buffer_create(string_byte_length(payload_string), buffer_fixed, 1);
    buffer_write(buffer_payload, buffer_text, payload_string);
    buffer_seek(buffer_payload, buffer_seek_start, 0);


    var request_id = http_request(url, "POST", headers, buffer_payload);

    ds_map_destroy(headers);

    buffer_map[? request_id] = buffer_payload;

    return request_id;
}
