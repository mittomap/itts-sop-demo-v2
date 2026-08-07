# ITTs SOP - Bản demo V2 (mỗi nghiệp vụ một trang)

Bản demo web app của trung tâm IELTS The Tutors, **bản V2**.

- Cổng nhân viên: https://mittomap.github.io/itts-sop-demo-v2/cong-nhan-vien/
- Cổng học viên: https://mittomap.github.io/itts-sop-demo-v2/cong-hoc-vien/
- Trang chọn cổng: https://mittomap.github.io/itts-sop-demo-v2/

## V2 khác V1 chỗ nào

V1 gom 25 nghiệp vụ vào 6 trang hub, mỗi hub một dải tab. V2 tách ra: **mỗi nghiệp vụ một
trang riêng**, có tiêu đề riêng, thẻ riêng, chip lọc riêng và dải cảnh báo riêng. Sidebar vẫn
sắp theo chặng vòng đời, nên vẫn đi được theo luồng - nhưng người không đi theo luồng (đa số
các vị trí ngoài sale) thì vào thẳng trang nghiệp vụ của mình.

Bản V1 vẫn chạy song song, không bị đụng: https://mittomap.github.io/itts-sop-demo/

## Repo này chỉ là chỗ ĐẶT bản build

Không sửa gì ở đây. Nguồn duy nhất là `_src/gen_v5.py` trong repo
[mittomap/tts-sop-structor](https://github.com/mittomap/tts-sop-structor), nhánh
`claude/tts-sop-v2-single-page-4olkq4`. Sửa nguồn, dựng lại, chạy `./update.sh` để đẩy sang đây.
