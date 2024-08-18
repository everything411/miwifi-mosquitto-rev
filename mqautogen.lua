local L0, L1, L2, L3, L4, L5, L6, L7, L8, L9, L10, L11, L12, L13, L14
L0 = require
L1 = "posix"
L0 = L0(L1)
posix = L0
L0 = "0"
debug = L0
L0 = "xiaoqiang"
d0 = L0
L0 = "miwifi"
d1 = L0
L0 = "/usr/bin/openssl"
op = L0
L0 = "xiaoqiang"
DOMAIN = L0
L0 = "/CN="
L1 = d0
L0 = L0 .. L1
SUBJECT = L0
L0 = "/tmp/mq/cc/"
dir = L0
L0 = "/usr/share/xiaoqiang/cc/"
dir_fix = L0
L0 = "mq_a1"
a1 = L0
L0 = "mq_b1"
b1 = L0
L0 = DOMAIN
L1 = "_ky"
L0 = L0 .. L1
c0 = L0
L0 = DOMAIN
L1 = "_ct"
L0 = L0 .. L1
c1 = L0
L0 = DOMAIN
L1 = "_rs"
L0 = L0 .. L1
c2 = L0
L0 = DOMAIN
L1 = "_srl"
L0 = L0 .. L1
c3 = L0
L0 = dir_fix
L1 = a1
L0 = L0 .. L1
path_a1 = L0
L0 = dir_fix
L1 = b1
L0 = L0 .. L1
path_b1 = L0
L0 = dir
L1 = c0
L0 = L0 .. L1
path_c0 = L0
L0 = dir
L1 = c1
L0 = L0 .. L1
path_c1 = L0
L0 = dir
L1 = c2
L0 = L0 .. L1
path_c2 = L0
L0 = dir
L1 = c3
L0 = L0 .. L1
path_c3 = L0
function L0(A0)
  local L1, L2, L3, L4, L5
  L1 = debug
  if L1 == "1" then
    L1 = print
    L2 = "==cmd:"
    L3 = A0
    L2 = L2 .. L3
    L1(L2)
  end
  L1 = io
  L1 = L1.popen
  L2 = A0
  L1 = L1(L2)
  L2 = print
  L4 = L1
  L3 = L1.read
  L5 = "*a"
  L3, L4, L5 = L3(L4, L5)
  L2(L3, L4, L5)
  L3 = L1
  L2 = L1.close
  L2(L3)
end
exec_cmd = L0
function L0()
  local L0, L1
  L0 = debug
  if L0 == "1" then
    L0 = " -verbose"
    return L0
  else
    L0 = " 2>/dev/null"
    return L0
  end
end
cmd_tail = L0
L0 = posix
L0 = L0.access
L1 = op
L2 = "f"
L0 = L0(L1, L2)
if not L0 then
  L0 = print
  L1 = "cannot exec "
  L2 = op
  L1 = L1 .. L2
  L0(L1)
  L0 = 0
  return L0
end
L0 = posix
L0 = L0.access
L1 = path_a1
L2 = "r"
L0 = L0(L1, L2)
if L0 then
  L0 = posix
  L0 = L0.access
  L1 = path_b1
  L2 = "r"
  L0 = L0(L1, L2)
  if L0 then
    goto lbl_104
  end
end
L0 = print
L1 = "cannot read ca files."
L0(L1)
L0 = 0
do return L0 end
::lbl_104::
L0 = posix
L0 = L0.access
L1 = dir
L2 = "w"
L0 = L0(L1, L2)
if not L0 then
  L0 = exec_cmd
  L1 = "mkdir -p "
  L2 = dir
  L1 = L1 .. L2
  L0(L1)
end
L0 = posix
L0 = L0.access
L1 = path_c0
L2 = "r"
L0 = L0(L1, L2)
if L0 then
  L0 = posix
  L0 = L0.access
  L1 = path_c1
  L2 = "r"
  L0 = L0(L1, L2)
  if L0 then
    L0 = print
    L1 = "exist, exit."
    L0(L1)
    L0 = 0
    return L0
  end
end
L0 = exec_cmd
L1 = "rm -rf "
L2 = dir
L3 = "*"
L1 = L1 .. L2 .. L3
L0(L1)
L0 = exec_cmd
L1 = op
L2 = " genrsa -out "
L3 = path_c0
L4 = " 2048 "
L5 = cmd_tail
L5 = L5()
L1 = L1 .. L2 .. L3 .. L4 .. L5
L0(L1)
L0 = exec_cmd
L1 = op
L2 = " req -new -subj "
L3 = SUBJECT
L4 = " -key "
L5 = path_c0
L6 = " -out "
L7 = path_c2
L8 = cmd_tail
L8 = L8()
L1 = L1 .. L2 .. L3 .. L4 .. L5 .. L6 .. L7 .. L8
L0(L1)
L0 = exec_cmd
L1 = op
L2 = " x509 -req -days 36500 -passin pass:"
L3 = d1
L4 = " -in "
L5 = path_c2
L6 = " -CA "
L7 = path_a1
L8 = " -CAkey "
L9 = path_b1
L10 = " -CAserial "
L11 = path_c3
L12 = " -CAcreateserial -out "
L13 = path_c1
L14 = " 2>/dev/null"
L1 = L1 .. L2 .. L3 .. L4 .. L5 .. L6 .. L7 .. L8 .. L9 .. L10 .. L11 .. L12 .. L13 .. L14
L0(L1)
L0 = exec_cmd
L1 = op
L2 = " verify -CAfile "
L3 = path_a1
L4 = " "
L5 = path_c1
L1 = L1 .. L2 .. L3 .. L4 .. L5
L0(L1)
L0 = exec_cmd
L1 = "rm -rf "
L2 = path_c2
L3 = " "
L4 = path_c3
L1 = L1 .. L2 .. L3 .. L4
L0(L1)
