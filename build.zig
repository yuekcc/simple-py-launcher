const std = @import("std");

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    {
        const exe = b.addExecutable(.{
            .name = "pystart",
            .target = target,
            .optimize = optimize,
        });
        const flags = [_][]const u8{
            "-DWIN32",
            "-DNDEBUG",
            "-DUSE_ENVIRONMENT",
            "-D_CONSOLE",
        };
        exe.addCSourceFiles(.{ .files = &[_][]const u8{
            "PC/launcher.c",
        }, .flags = &flags });
        exe.addWin32ResourceFile(.{ .file = .{ .cwd_relative = "PC/launcher.rc" } });
        exe.linkLibCpp();
        exe.linkSystemLibrary("shlwapi");
        b.installArtifact(exe);
    }
}
