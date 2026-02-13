import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter/services.dart';

class AdminDashboard extends StatefulWidget {
  const AdminDashboard({super.key});

  @override
  AdminDashboardState createState() => AdminDashboardState();
}

class AdminDashboardState extends State<AdminDashboard>
    with AutomaticKeepAliveClientMixin {
  List allApplicationData = [];
  List filteredApplicationData = [];
  String filterStatus = "All";
  String degreeFilter = "All";
  String? paidFilter;
  String searchQuery = "";
  bool isSearching = false;
  final TextEditingController searchController = TextEditingController();

  final ScrollController _verticalController = ScrollController();
  final ScrollController _horizontalController = ScrollController();

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    fetchApplications();
  }

  @override
  void dispose() {
    _verticalController.dispose();
    _horizontalController.dispose();
    searchController.dispose();
    super.dispose();
  }

  Future<void> fetchApplications() async {
    try {
      final response = await http.get(
        Uri.parse("https://rks2ql97-3010.inc1.devtunnels.ms/applications"),
      );

      if (response.statusCode == 200) {
        allApplicationData = json.decode(response.body);
        // Newest first
        allApplicationData = allApplicationData.reversed.toList();
        filterAndSearch();
        setState(() {});
      }
    } catch (e) {
      // Handle error if needed
    }
  }

  bool isPaid(String? x) => x != null && x.toLowerCase() == "paid";

  void filterAndSearch() {
    var list = List.from(allApplicationData);

    if (filterStatus != "All") {
      list = list
          .where((e) =>
      e["coursename"].toString().toLowerCase() ==
          filterStatus.toLowerCase())
          .toList();
    }

    if (degreeFilter != "All") {
      list = list
          .where((e) =>
      (e["degree"] ?? "").toString().toLowerCase() ==
          degreeFilter.toLowerCase())
          .toList();
    }

    if (paidFilter == "Paid") {
      list = list.where((e) => isPaid(e["payment_status"])).toList();
    } else if (paidFilter == "Not Paid") {
      list = list.where((e) => !isPaid(e["payment_status"])).toList();
    }

    if (searchQuery.isNotEmpty) {
      final q = searchQuery.toLowerCase();
      list = list
          .where((e) =>
      e["studentname"].toString().toLowerCase().contains(q) ||
          e["email"].toString().toLowerCase().contains(q) ||
          e["phone"].toString().toLowerCase().contains(q) ||
          e["college_name"].toString().toLowerCase().contains(q))
          .toList();
    }

    // Reverse filtered results too
    list = list.reversed.toList();
    filteredApplicationData = list;
    setState(() {});
  }

  Widget highlight(String src, String q) {
    if (q.isEmpty) return Text(src);
    final lower = src.toLowerCase();
    final qLower = q.toLowerCase();
    final List<TextSpan> spans = [];
    int start = 0;
    int index = lower.indexOf(qLower);

    while (index != -1) {
      if (index > start) {
        spans.add(TextSpan(text: src.substring(start, index)));
      }
      spans.add(
        TextSpan(
          text: src.substring(index, index + q.length),
          style: const TextStyle(
            backgroundColor: Colors.yellow,
            fontWeight: FontWeight.bold,
          ),
        ),
      );
      start = index + q.length;
      index = lower.indexOf(qLower, start);
    }
    if (start < src.length) {
      spans.add(TextSpan(text: src.substring(start)));
    }

    return RichText(
      text: TextSpan(
        style: const TextStyle(color: Colors.black),
        children: spans,
      ),
    );
  }

  void copyID(String id) {
    Clipboard.setData(ClipboardData(text: id));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Transaction ID copied")),
    );
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return Scaffold(
      backgroundColor: Colors.brown.shade50.withValues(alpha: 0.8),
      appBar: AppBar(
        centerTitle: true,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back),
        //   onPressed: () => Navigator.pop(context),
        // ),
        title: const Text(
          "Admin Dashboard",
          style: TextStyle(fontSize: 29),
        ),
        // automaticallyImplyLeading: false,
        actions: [
          if (!isSearching)
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () => setState(() => isSearching = true),
            ),
          if (isSearching)
            Container(
              width: 200,
              margin: const EdgeInsets.symmetric(horizontal: 12),
              child: TextField(
                controller: searchController,
                onChanged: (v) {
                  searchQuery = v;
                  filterAndSearch();
                },
                decoration: InputDecoration(
                  hintText: "Search...",
                  prefixIcon: const Icon(Icons.search),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      searchQuery = "";
                      isSearching = false;
                      searchController.clear();
                      filterAndSearch();
                    },
                  ),
                  filled: true,
                  fillColor: Colors.white.withOpacity(0.1),
                  border: OutlineInputBorder(
                    borderSide: BorderSide.none,
                    borderRadius: BorderRadius.circular(24),
                  ),
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) {
            return SingleChildScrollView(
              padding: const EdgeInsets.only(bottom: 16),
              scrollDirection: Axis.vertical,
              child: ConstrainedBox(
                constraints: BoxConstraints(minHeight: constraints.maxHeight),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const SizedBox(height: 10),

                    // Payment Filter
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        const Text("Payment Status "),
                        Radio(
                          value: "Paid",
                          groupValue: paidFilter,
                          onChanged: (v) {
                            paidFilter = v;
                            filterAndSearch();
                          },
                        ),
                        const Text("Paid"),
                        Radio(
                          value: "Not Paid",
                          groupValue: paidFilter,
                          onChanged: (v) {
                            paidFilter = v;
                            filterAndSearch();
                          },
                        ),
                        const Text("Not Paid"),
                        Radio<String?>(
                          value: null,
                          groupValue: paidFilter,
                          onChanged: (v) {
                            paidFilter = v;
                            filterAndSearch();
                          },
                        ),
                        const Text("All"),
                        const SizedBox(width: 16),
                      ],
                    ),

                    // Filters
                    Container(
                      padding: const EdgeInsets.all(12),
                      child: Row(
                        children: [
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              filterStatus = v;
                              filterAndSearch();
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                  value: "All", child: Text("All")),
                              PopupMenuItem(
                                  value: "Flutter", child: Text("Flutter")),
                              PopupMenuItem(
                                  value: "Node JS", child: Text("Node JS")),
                              PopupMenuItem(
                                  value: "React", child: Text("React")),
                              PopupMenuItem(
                                  value: "C++", child: Text("C++")),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.filter_list),
                                  const SizedBox(width: 8),
                                  Text(filterStatus),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(width: 20),
                          PopupMenuButton<String>(
                            onSelected: (v) {
                              degreeFilter = v;
                              filterAndSearch();
                            },
                            itemBuilder: (_) => const [
                              PopupMenuItem(
                                  value: "All",
                                  child: Text("All Degrees")),
                              PopupMenuItem(
                                  value: "B.Sc", child: Text("B.Sc")),
                              PopupMenuItem(
                                  value: "M.Sc", child: Text("M.Sc")),
                              PopupMenuItem(
                                  value: "BCA", child: Text("BCA")),
                              PopupMenuItem(
                                  value: "MCA", child: Text("MCA")),
                              PopupMenuItem(
                                  value: "B.E", child: Text("B.E")),
                              PopupMenuItem(
                                  value: "M.E", child: Text("M.E")),
                              PopupMenuItem(
                                  value: "B.Tech", child: Text("B.Tech")),
                              PopupMenuItem(
                                  value: "M.Tech", child: Text("M.Tech")),
                            ],
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(24),
                            ),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.black),
                                borderRadius: BorderRadius.circular(24),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.school),
                                  const SizedBox(width: 8),
                                  Text(degreeFilter),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // Table
                    SizedBox(
                      height: 530,
                      child: Scrollbar(
                        controller: _verticalController,
                        thumbVisibility: true,
                        child: Scrollbar(
                          controller: _horizontalController,
                          thumbVisibility: true,
                          notificationPredicate: (notif) =>
                          notif.metrics.axis == Axis.horizontal,
                          child: SingleChildScrollView(
                            controller: _horizontalController,
                            scrollDirection: Axis.horizontal,
                            child: SingleChildScrollView(
                              controller: _verticalController,
                              scrollDirection: Axis.vertical,
                              child: DataTable(
                                columns: const [
                                  DataColumn(label: Text("S.No")),
                                  DataColumn(label: Text("Name")),
                                  DataColumn(label: Text("Phone")),
                                  DataColumn(label: Text("Email")),
                                  DataColumn(label: Text("Course")),
                                  DataColumn(label: Text("Degree")),
                                  DataColumn(label: Text("Subject")),
                                  DataColumn(label: Text("College")),
                                  DataColumn(label: Text("Year")),
                                  DataColumn(label: Text("Amount")),
                                  DataColumn(label: Text("Transaction ID")),
                                  DataColumn(label: Text("Payment Status")),
                                  DataColumn(label: Text("Date/Time")),
                                ],
                                rows: List.generate(
                                  filteredApplicationData.length,
                                      (i) {
                                    final e = filteredApplicationData[i];
                                    return DataRow(
                                      cells: [
                                        DataCell(Text("${i + 1}")),
                                        DataCell(
                                          highlight(
                                            e["studentname"]?.toString() ?? "",
                                            searchQuery,
                                          ),
                                        ),
                                        DataCell(
                                          highlight(
                                            e["phone"]?.toString() ?? "",
                                            searchQuery,
                                          ),
                                        ),
                                        DataCell(
                                          highlight(
                                            e["email"]?.toString() ?? "",
                                            searchQuery,
                                          ),
                                        ),
                                        DataCell(
                                          highlight(
                                            e["coursename"]?.toString() ?? "",
                                            searchQuery,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["degree"]?.toString() ?? "",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["subject"]?.toString() ?? "",
                                          ),
                                        ),
                                        DataCell(
                                          highlight(
                                            e["college_name"]
                                                ?.toString() ??
                                                "",
                                            searchQuery,
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["year_of_study"]
                                                ?.toString() ??
                                                "",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["amount"]?.toString() ?? "",
                                          ),
                                        ),
                                        DataCell(
                                          Row(
                                            children: [
                                              Flexible(
                                                child: Text(
                                                  e["transaction_id"]
                                                      ?.toString() ??
                                                      "",
                                                  overflow:
                                                  TextOverflow.ellipsis,
                                                ),
                                              ),
                                              IconButton(
                                                icon: const Icon(
                                                  Icons.copy,
                                                  size: 16,
                                                ),
                                                onPressed: () => copyID(
                                                  e["transaction_id"]
                                                      ?.toString() ??
                                                      "",
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["payment_status"]
                                                ?.toString() ??
                                                "",
                                          ),
                                        ),
                                        DataCell(
                                          Text(
                                            e["createdtime"]
                                                ?.toString() ??
                                                "",
                                          ),
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
