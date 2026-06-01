import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:reviews_link_v2/data/constant/api_constant.dart';
import 'package:reviews_link_v2/data/models/body/codes/assign_code_to_service_body.dart';
import 'package:reviews_link_v2/data/models/body/codes/get_my_codes_body.dart';
import 'package:reviews_link_v2/data/models/response/codes/codes_response.dart';
import 'package:reviews_link_v2/data/repository/codes_repo.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:reviews_link_v2/pages/services/models/service_model.dart';
import 'package:reviews_link_v2/widgets/snack_bar/top_snack_bar.dart';

class MyCodesController extends GetxController {
  RxList<CodesResponse> codesList = <CodesResponse>[].obs;
  RxBool loading = false.obs;
  RxBool loadingAssign = false.obs;
  CodesRepo codesRepo = CodesRepo();

  TextEditingController searchController = TextEditingController();

  ServiceModel? selectService;

  RxList<CodesResponse> filteredList = <CodesResponse>[].obs;

  void filterServices() {
    final query = searchController.text.toLowerCase();
    if (query.isEmpty) {
      filteredList.value = List.from(codesList);
    } else {
      filteredList.value = codesList.where((item) {
        final code = item.code.toString().toLowerCase();
        return code.contains(query);
      }).toList();
    }
    update();
  }

  getCodesList() async {
    codesList.clear();
    loading.value = true;
    await codesRepo.getMyCodes(GetMyCodesBody(page: 1, perPage: 100)).then((
      value,
    ) async {
      if (value.code == 200) {
        final List codesJson = value.body['codes'] as List;

        final codes = codesJson.map((e) => CodesResponse.fromJson(e)).toList();

        codesList.addAll(codes);
        filteredList.clear();
        filteredList.value = List.from(codesList);
        loading.value = false;
      } else {
        loading.value = false;
      }
    });
  }

  assignCode(codeId, serviceId, BuildContext context) async {
    if (!loadingAssign.value) {
      loadingAssign.value = true;
      Get.back();
      await codesRepo
          .assignCodeToService(
            AssignCodeToServiceBody(codeId: codeId, serviceId: serviceId),
          )
          .then((value) async {
            if (value.code == 200) {
              TopSnackBar.success(context, value.message);
              selectService = null;
              loadingAssign.value = false;
              await getCodesList();
            } else {
              TopSnackBar.warning(context, value.message);
              loadingAssign.value = false;
            }
          });
    }
  }

  @override
  void onInit() async {
    await getCodesList();
    filteredList.clear();
    filteredList.value = List.from(codesList);
    searchController.addListener(() {
      filterServices();
    });
    super.onInit();
  }

  // @override
  // void initState() {
  //   super.initState();
  //   myCodesController.filteredList = List.from(myCodesController.myCodesList);
  //   myCodesController.searchController.addListener(() {
  //     myCodesController.filterServices();
  //     setState(() {});
  //   });
  // }
  Future<void> printCodePdf(String code) async {
    final pdf = pw.Document();
    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a4,
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisSize: pw.MainAxisSize.min,
              children: [
                pw.BarcodeWidget(
                  data: '$baseUrl/$code',
                  barcode: pw.Barcode.qrCode(),
                  width: Get.width * 0.6,
                  height: Get.width * 0.6,
                ),
                pw.SizedBox(height: 50),
                pw.Text(
                  code,
                  style: pw.TextStyle(
                    fontWeight: pw.FontWeight.bold,
                    fontSize: 40,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }
}
