import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
//su dung url

class InforPage extends StatelessWidget {
  const InforPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFE3F2FD),
      body: SafeArea(
        child: Column(
          children: [
            // AppBar nổi nhẹ — giống bên trang Nhiệm vụ
            Container(
              margin: const EdgeInsets.symmetric(
                horizontal: 12,
                vertical: 8,
              ),
              decoration: BoxDecoration(
                color: Colors.blue,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              padding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 14,
              ),
              child: const Center(
                child: Text(
                  "THÔNG TIN NHÓM",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    letterSpacing: 1.2,
                  ),
                ),
              ),
            ),

            // Nội dung
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(24.0),
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    ClipOval(
                      child: Image.asset(
                        'imgs/hanhdang.jpg',
                        width: 200,
                        height: 200,
                        fit: BoxFit.cover,
                      ),
                    ),

                    const SizedBox(height: 30),

                    _buildInfoBox(
                      title: "Thành viên:",
                      content: const [
                        Text("Nguyễn Đăng Hanh - 23010243"),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildInfoBox(
                      title: "Github:",
                      content: [
                        InkWell(
                          onTap: () async {
                            const url =
                                "https://github.com/HannhhDangg/2025_LTTBDD_N04_Nhom_HanhNguyenDang";
                            final uri = Uri.parse(url);
                            if (!await launchUrl(
                              uri,
                              mode: LaunchMode
                                  .externalApplication,
                            )) {
                              throw Exception(
                                'Không thể mở $url',
                              );
                            }
                          },
                          child: const Text(
                            "https://github.com/HannhhDangg/2025_LTTBDD_N04_Nhom_HanhNguyenDang",
                            style: TextStyle(
                              color: Colors.blue,
                              fontWeight: FontWeight.w500,
                              decoration:
                                  TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    _buildInfoBox(
                      title:
                          "Vai trò và công việc thực hiện:",
                      content: const [
                        Text(
                          "• Lên ý tưởng và xây dựng ứng dụng quản lý thời gian biểu cá nhân (Todo App).",
                        ),
                        Text(
                          "• Thiết kế giao diện ứng dụng theo chuẩn UI/UX.",
                        ),
                        Text(
                          "• Thiết kế cấu trúc ứng dụng và triển khai các chức năng chính (thêm, sửa, xóa, đánh dấu hoàn thành).",
                        ),
                        Text(
                          "• Thực hiện kiểm thử và đánh giá chất lượng ứng dụng.",
                        ),
                        Text(
                          "• Chuẩn bị slide báo cáo, demo ứng dụng và soạn thảo báo cáo môn học.",
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoBox({
    required String title,
    required List<Widget> content,
  }) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          const SizedBox(height: 8),
          ...content,
        ],
      ),
    );
  }
}
