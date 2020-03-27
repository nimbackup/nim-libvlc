import nimterop/[build, cimport], os

const
  baseDir = currentSourcePath.parentDir() / "build"
  dynvlc =
    when defined(windows):
      "libvlc.dll"
    else:
      "libvlc.so(.5|.5.6.0|)"

static:
  gitPull("https://git.videolan.org/git/vlc.git", outdir=baseDir, 
    plist = "include/*"
  )
  cSkipSymbol(
    @["video_setup_device_info_t", # Nested struct
      "teletext_key_t", # Enum with bit shifting in value definition
      "teletext_key_red", 
      "teletext_key_green", 
      "teletext_key_yellow", 
      "teletext_key_blue", 
      "teletext_key_index"
      ]
  )

cIncludeDir(baseDir / "include")

cPlugin:
  import strutils

  proc onSymbol*(sym: var Symbol) {.exportc, dynlib.} =
    # Remove prefixes or suffixes from procs
    if sym.name.contains("libvlc_"):
      sym.name = sym.name.replace("libvlc_", "")


cImport(baseDir / "include" / "vlc_messages.h", dynlib = "dynvlc")

cOverride:
  type
    INNER_C_STRUCT_tt_5* {.bycopy.} = object
      device_context*: pointer   ## * ID3D11DeviceContext*

    INNER_C_STRUCT_tt_8* {.bycopy.} = object
      device*: pointer           ## * IDirect3D9*
      adapter*: cint             ## * Adapter to use with the IDirect3D9*

    INNER_C_UNION_tt_4* {.bycopy, union.} = object
      d3d11*: INNER_C_STRUCT_tt_5
      d3d9*: INNER_C_STRUCT_tt_8

    video_setup_device_info_t* {.bycopy.} = object
      ano_tt_11*: INNER_C_UNION_tt_4

    INNER_C_UNION_ff_4* {.bycopy, union.} = object
      dxgi_format*: cint         ## * the rendering DXGI_FORMAT for \ref libvlc_video_engine_d3d11
      d3d9_format*: uint32     ## * the rendering D3DFORMAT for \ref libvlc_video_engine_d3d9
      opengl_format*: cint ## * the rendering GLint GL_RGBA or GL_RGB for \ref libvlc_video_engine_opengl and
                        ##                              for \ref libvlc_video_engine_gles2
      p_surface*: pointer        ## * currently unused

    video_output_cfg_t* {.bycopy.} = object
      ano_ff_9*: INNER_C_UNION_ff_4
      full_range*: bool          ## * video is full range or studio/limited range
      colorspace*: video_color_space_t ## * video color space
      primaries*: video_color_primaries_t ## * video color primaries
      transfer*: video_transfer_func_t ## * video transfer function

  const
    teletext_key_red = ord('r') shl 16
    teletext_key_green = ord('g') shl 16
    teletext_key_yellow = ord('b') shl 16
    teletext_key_blue = ord('y') shl 16
    teletext_key_index = ord('i') shl 16

cImport(baseDir / "include" / "vlc" / "vlc.h", recurse = true, dynlib = "dynvlc")