var i = 0;
while (i < ds_list_size(cleanup_list)) {
    var cleanup_id = cleanup_list[| i];
    if (ds_map_exists(buffer_map, cleanup_id)) {
        buffer_delete(buffer_map[? cleanup_id]);
        ds_map_delete(buffer_map, cleanup_id);
        ds_list_delete(cleanup_list, i);
    } else {
        i++;
    }
}

if (ds_list_size(cleanup_list) > 0) {
    alarm[0] = 2;
}