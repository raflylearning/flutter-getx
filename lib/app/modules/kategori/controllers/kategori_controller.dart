import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../../data/kategori_model.dart';
import '../../../utils/api.dart';

class KategoriController extends GetxController {
  var kategoriList = <DataKategori>[].obs;
  var isLoading = true.obs;

  final String baseUrl = '${BaseUrl.api}/kategori';

  @override
  void onInit() {
    fetchKategories();
    super.onInit();
  }

  // fetch kategori
  void fetchKategories() async {
    try {
      isLoading(true);
      final response = await http.get(Uri.parse(baseUrl));
      if (response.statusCode == 200) {
        var jsonResponse = json.decode(response.body);
        var kategori = Kategori.fromJson(jsonResponse);
        kategoriList.value = kategori.data!;
      } else {
        Get.snackbar("Error", "Failed to fetch categories");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to fetch categories: $e");
    } finally {
      isLoading(false);
    }
  }

  //ADD Kategori
  Future<void> addKategori(DataKategori newKategori) async {
    try {
      isLoading(true);
      final response = await http.post(
        Uri.parse(baseUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(newKategori.toJson()),
      );
      if (response.statusCode == 201) {
        fetchKategories();
        Get.back();
        Get.snackbar("Success", "Category added successfully");
      } else {
        Get.snackbar("Error", "Failed to add category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to add kategori: $e");
    } finally {
      isLoading(false);
    }
  }

  // update kategori
  Future<void> updateKategori(int id, DataKategori updatedKategori) async {
    try {
      isLoading(true);
      final response = await http.put(
        Uri.parse('$baseUrl/$id'),
        headers: {"Content-Type": "application/json"},
        body: json.encode(updatedKategori.toJson()),
      );
      if (response.statusCode == 200) {
        fetchKategories();
        Get.back();
        Get.snackbar("Success", "Category updated successfully");
      } else {
        Get.snackbar("Error", "Failed to update category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to update kategori: $e");
    } finally {
      isLoading(false);
    }
  }

  //delete kategori
  Future<void> deleteKategori(int id) async {
    try {
      isLoading(true);
      final response = await http.delete(Uri.parse('$baseUrl/$id'));
      if (response.statusCode == 200) {
        fetchKategories();
        Get.snackbar("Success", "Category deleted successfully");
      } else {
        Get.snackbar("Error", "Failed to delete category");
      }
    } catch (e) {
      Get.snackbar("Error", "Failed to delete category: $e");
    } finally {
      isLoading(false);
    }
  }
}
