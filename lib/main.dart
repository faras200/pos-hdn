import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pos_hdn/core/constants/colors.dart';
import 'package:pos_hdn/data/datasources/auth_local_datasource.dart';
import 'package:pos_hdn/data/datasources/auth_remote_datasource.dart';
import 'package:pos_hdn/data/datasources/order_remote_datasource.dart';
import 'package:pos_hdn/data/datasources/product_remote_datasource.dart';
import 'package:pos_hdn/data/datasources/qris_dbs_remote_datasource.dart';
import 'package:pos_hdn/presentations/auth/bloc/login/login_bloc.dart';
import 'package:pos_hdn/presentations/auth/pages/login_page.dart';
import 'package:pos_hdn/presentations/history/bloc/history/history_bloc.dart';
import 'package:pos_hdn/presentations/history/bloc/history_detail/history_detail_bloc.dart';
import 'package:pos_hdn/presentations/home/bloc/checkout/checkout_bloc.dart';
import 'package:pos_hdn/presentations/home/bloc/logout/logout_bloc.dart';
import 'package:pos_hdn/presentations/home/bloc/product/product_bloc.dart';
import 'package:pos_hdn/presentations/home/pages/dashboard_page.dart';
import 'package:pos_hdn/presentations/manage/bloc/setoran/setoran_bloc.dart';
import 'package:pos_hdn/presentations/manage/bloc/sync_order/sync_order_bloc.dart';
import 'package:pos_hdn/presentations/manage/pages/setoran/setoran_page.dart';
import 'package:pos_hdn/presentations/order/bloc/order/order_bloc.dart';
import 'package:pos_hdn/presentations/order/bloc/qris/qris_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => LogoutBloc(AuthRemoteDataSource()),
        ),
        BlocProvider(
          create: (context) => ProductBloc(ProductRemoteDatasource())
            ..add(const ProductEvent.fetch()),
        ),
        BlocProvider(
          create: (context) => CheckoutBloc(),
        ),
        BlocProvider(
          create: (context) => OrderBloc(),
        ),
        BlocProvider(
          create: (context) => QrisBloc(QrisDbsRemoteDatasource()),
        ),
        BlocProvider(
          create: (context) => HistoryBloc(),
        ),
        BlocProvider(
          create: (context) => HistoryDetailBloc(),
        ),
        BlocProvider(
          create: (context) => SyncOrderBloc(OrderRemoteDatasource.instance),
        ),
        BlocProvider(
          create: (context) => SetoranBloc(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'POS_HDN',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: AppColors.primary),
          useMaterial3: true,
          textTheme: GoogleFonts.quicksandTextTheme(
            Theme.of(context).textTheme,
          ),
          appBarTheme: AppBarTheme(
            color: AppColors.primary,
            elevation: 0,
            titleTextStyle: GoogleFonts.quicksand(
              color: AppColors.white,
              fontSize: 16.0,
              fontWeight: FontWeight.w500,
            ),
            iconTheme: const IconThemeData(
              color: AppColors.white,
            ),
          ),
        ),
        home: FutureBuilder<bool>(
            future: AuthLocalDatasource().isAuth(),
            builder: (context, snapshot) {
              if (snapshot.hasData && snapshot.data == true) {
                return const DashboardPage();
              } else {
                return const LoginPage();
              }
            }),
        routes: {
          "/dashboard": (_) => const DashboardPage(),
          "/setoran": (_) => const SetoranPage(),
        },
      ),
    );
  }
}
