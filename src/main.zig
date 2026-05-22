const std = @import("std");

const DbHeader = extern struct {
    magic: [8]u8,
    version: u32,
    page_size: u32,
};

const PAGE_SIZE = 4096;

const Page = extern struct {
    data: [PAGE_SIZE]u8,
};

pub fn main() !void {
    const stdout = std.io.getStdOut().writer();

    const header = DbHeader{
        .magic = "SOULCODE".*,
        .version = 1,
        .page_size = PAGE_SIZE,
    };

    var first_page = Page{
        .data = [_]u8{0} ** PAGE_SIZE,
    };

    const test_msg = "Hello from Page 1 - SoulDB is alive!";
    @memcpy(first_page.data[0..test_msg.len], test_msg);

    {
        const file = try std.fs.cwd().createFile("soul.db", .{});
        defer file.close();

        try file.writeAll(std.mem.asBytes(&header));

        try file.writeAll(std.mem.asBytes(&first_page));

        try stdout.print(" Файл soul.db створено ({d} байт).\n", .{try file.getEndPos()});
    }

    {
        const file = try std.fs.cwd().openFile("soul.db", .{});
        defer file.close();

        var loaded_header: DbHeader = undefined;

        _ = try file.readAll(std.mem.asBytes(&loaded_header));

        if (std.mem.eql(u8, &loaded_header.magic, "SOULCODE")) {
            try stdout.print(" Валідація успішна: Знайдено сигнатуру {s}\n", .{loaded_header.magic});
            try stdout.print(" Параметри БД: Версія {d}, Розмір сторінки {d} байт\n", .{ loaded_header.version, loaded_header.page_size });
        } else {
            try stdout.print(" Помилка: Файл пошкоджений або має невірний формат!\n", .{});
        }

        var loaded_page: Page = undefined;
        _ = try file.readAll(std.mem.asBytes(&loaded_page));

        try stdout.print(" Дані першої сторінки: {s}\n", .{loaded_page.data[0..35]});
    }
}
