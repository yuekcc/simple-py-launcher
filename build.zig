const std = @import("std");

const console_flags = [_][]const u8{
    "-DWIN32",
    "-D_DEBUG",
    "-D_CONSOLE",
};

const gui_flags = [_][]const u8{
    "-DWIN32",
    "-D_DEBUG",
    "-D_WINDOWS",
};

const src_files = [_][]const u8{
    "PC/launcher.c",
};

fn build_cli(b: *std.Build, target: std.Build.ResolvedTarget, optimize: std.builtin.OptimizeMode, for_gui: bool) void {
    const exe = b.addExecutable(.{
        .name = if (for_gui) "pystartw" else "pystart",
        .target = target,
        .optimize = optimize,
    });

    const flags = if (for_gui) gui_flags else console_flags;
    exe.addCSourceFiles(.{ .files = &src_files, .flags = &flags });
    exe.addWin32ResourceFile(.{ .file = .{ .cwd_relative = "PC/launcher.rc" } });
    exe.linkLibCpp();
    exe.linkSystemLibrary("shlwapi");
    b.installArtifact(exe);
}

pub fn build(b: *std.Build) void {
    const target = b.standardTargetOptions(.{});
    const optimize = b.standardOptimizeOption(.{});

    build_cli(b, target, optimize, true);
    build_cli(b, target, optimize, false);
}
