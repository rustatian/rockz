const std = @import("std");
const testing = std.testing;

test "decode file test" {
    var file = try std.fs.cwd().openFile("./test_artifacts/CPU.pb.gz", .{});
    defer file.close();

    const file_to_write = try std.fs.cwd().createFile("./test_artifacts/test.txt", .{});

    var buf = std.io.bufferedReader(file.reader());
    try std.compress.gzip.decompress(buf.reader(), file_to_write);

    file_to_write.close();
    try std.fs.cwd().deleteFile("./test_artifacts/test.txt");
}
