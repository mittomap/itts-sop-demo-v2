#!/usr/bin/env bash
# Chep ban V2 moi nhat tu nguon vao repo demo V2, commit va push.
#
# BAN V2 = MOI NGHIEP VU MOT TRANG. No song song voi ban V1 (repo `itts-sop-demo`), KHONG de len
# nhau: hai repo rieng, hai dia chi rieng, hai nhanh git rieng. Doi ban nao thi chay update.sh
# cua repo do - dung chep tay giua hai ben.
#
# Cau truc y het repo V1: moi cong mot THU MUC rieng va moi trang mot dia chi rieng
#   .../cong-nhan-vien/?trang-bat-dau      .../cong-hoc-vien/?hoc-phi
# File du lieu chi giu MOT ban o goc; hai file index.html tro ve ../ITTs_data.js
# (chep hai ban 3MB moi lan day thi repo phinh ra vo ich).
#
# BAY DA CAN NGUYEN MOT NGAY (05/08, ghi lai o BAN_GIAO_V2.md muc 3): trang demo online KHONG
# phuc vu file o goc repo - no phuc vu `cong-nhan-vien/index.html`. Va `gen_v5.py` mac dinh ghi
# vao `_src/`, nen build xong ma khong dat ITTS_OUT thi update.sh chep lai dung ban CU va bao
# "khong co thay doi de commit" - im lang hoan toan. Nen:
#   1) dung ra goc repo nguon:  ITTS_OUT=/duong/dan/tts-sop-structor python3 _src/gen_v5.py
#   2) chay update.sh nay
#   3) DOI CHIEU MA BAN DUNG (script tu lam o cuoi, khong phai nho tay)
set -euo pipefail
cd "$(dirname "$0")"
SRC="${ITTS_SRC:-$HOME/Claude/SOP ITTs}"
[ -d "$SRC" ] || SRC="/home/user/tts-sop-structor"   # phien cloud Claude Code
[ -f "$SRC/ITTs_WebApp_v5_demo.html" ] || { echo "LOI: khong thay nguon o $SRC - dat ITTS_SRC=<goc repo tts-sop-structor>"; exit 1; }

mkdir -p cong-nhan-vien cong-hoc-vien
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_WebApp_v5_demo.html" > cong-nhan-vien/index.html
sed 's|<script src="ITTs_data.js"></script>|<script src="../ITTs_data.js"></script>|' \
  "$SRC/ITTs_TrangHocVien_demo.html" > cong-hoc-vien/index.html
cp -f "$SRC/ITTs_data.js" ./ITTs_data.js
cp -f "$SRC/_src/trangchu_demo.html" ./index.html

# Chot cua: cua nao trang chu tro toi cung phai co file that. Da can mot lan o repo V1: trang chu
# them mot cua truoc, con update.sh khong biet co thu muc moi -> cua do 404 tren ban da day.
for c in $(grep -o 'href="[a-zA-Z0-9._/?-]*"' index.html | sed 's/href="//;s/"$//' \
           | grep -E '^(cong-|ITTs_)' | sed 's/?.*//'); do
  [ -e "$c" ] || [ -e "${c%/}/index.html" ] || { echo "LOI: trang chu tro toi $c ma khong co file"; exit 1; }
done

git add -A
git commit -m "cap nhat demo V2 $(date '+%Y-%m-%d %H:%M:%S')" || echo "Khong co thay doi de commit."
git push

# ── DOI CHIEU MA BAN DUNG - CHOT CUA DUY NHAT ────────────────────────────────────────────────
# Ma nay phai khop giua NGUON va ban vua day. Lech = online van dang chay ban cu.
_ma() { grep -oP 'id="navver"[^>]*>[^<]*<b>[a-f0-9]{6}' "$1" | grep -oP '[a-f0-9]{6}$' | head -1; }
MA_NGUON="$(_ma "$SRC/ITTs_WebApp_v5_demo.html")"
MA_DAY="$(_ma cong-nhan-vien/index.html)"
if [ -n "$MA_NGUON" ] && [ "$MA_NGUON" = "$MA_DAY" ]; then
  echo "MA BAN DUNG KHOP: $MA_DAY"
else
  echo "LOI: ma ban dung LECH - nguon=$MA_NGUON  da day=$MA_DAY"; exit 1
fi
echo "Xong. Cho GitHub Pages 1-2 phut roi mo: https://mittomap.github.io/itts-sop-demo-v2/"
echo "(xem lai nho Cmd+Shift+R de bo cache)"
