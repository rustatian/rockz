const std = @import("std");

pub const Buffer = struct {
    data: []const u8,
    curr_offset: usize,

    pub fn init(data: []const u8) Buffer {
        return Buffer{ .data = data, .curr_offset = 0 };
    }
};
