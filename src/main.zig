const std = @import("std");
const datetime = @import("./datetime.zig");
const buffer = @import("./buffer.zig");

pub const log_level: std.log.Level = .debug;

pub fn main() !void {
    const dt = datetime.DateTime.from_timestamp(@intCast(std.time.timestamp()));
    std.log.info("{}-{}-{}@{}:{}:{}: rockz is starting", .{ dt.year, dt.month, dt.day, dt.hour, dt.minute, dt.second });

    var args = std.process.args();
    while (args.next()) |arg| {
        std.log.info("arg: {s}", .{arg});
    }
}

test "parse test" {
    var file = try std.fs.cwd().openFile("./test_artifacts/CPU.pb.gz", .{});
    defer file.close();

    const file_to_write = try std.fs.cwd().createFile("./test_artifacts/test.txt", .{});

    var buf = std.io.bufferedReader(file.reader());
    try std.compress.gzip.decompress(buf.reader(), file_to_write);

    file_to_write.close();
    try std.fs.cwd().deleteFile("./test_artifacts/test.txt");
}
