import '/flutter_flow/flutter_flow_ad_banner.dart';
import '/flutter_flow/flutter_flow_theme.dart';
import '/flutter_flow/flutter_flow_util.dart';
import '/flutter_flow/admob_util.dart' as admob;
import '/index.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavigationWithAd extends StatelessWidget {
  final String currentPage;

  const BottomNavigationWithAd({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: 0,
      right: 0,
      bottom: 0,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: double.infinity,
            height: 80.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: currentPage != 'homepage'
                        ? () async {
                            context.pushNamed(HomepageWidget.routeName);
                          }
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: currentPage == 'homepage'
                                ? Color(0xFFFAF5FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.home,
                              color: currentPage == 'homepage'
                                  ? Color(0xFF9810FA)
                                  : Color(0xFF4A5565),
                              size: 24.0,
                            ),
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'zcwewsfe' /* Home */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: currentPage == 'homepage'
                                    ? Color(0xFF9810FA)
                                    : Color(0xFF4A5565),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                    FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                fontStyle:
                                    FlutterFlowTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: currentPage != 'aitools'
                        ? () async {
                            context.pushNamed(AitoolsWidget.routeName);
                          }
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: currentPage == 'aitools'
                                ? Color(0xFFFAF5FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.auto_awesome,
                              color: currentPage == 'aitools'
                                  ? Color(0xFF9810FA)
                                  : Color(0xFF4A5565),
                              size: 24.0,
                            ),
                          ),
                        ),
                        Text(
                          FFLocalizations.of(context).getText(
                            'ak149osq' /* AI Tools */,
                          ),
                          textAlign: TextAlign.center,
                          style: FlutterFlowTheme.of(context).bodySmall.override(
                                font: GoogleFonts.inter(
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                                color: currentPage == 'aitools'
                                    ? Color(0xFF9810FA)
                                    : Color(0xFF4A5565),
                                fontSize: 12.0,
                                letterSpacing: 0.0,
                                fontWeight:
                                    FlutterFlowTheme.of(context).bodySmall.fontWeight,
                                fontStyle:
                                    FlutterFlowTheme.of(context).bodySmall.fontStyle,
                              ),
                        ),
                      ],
                    ),
                  ),
                  InkWell(
                    splashColor: Colors.transparent,
                    focusColor: Colors.transparent,
                    hoverColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onTap: currentPage != 'mine'
                        ? () async {
                            context.pushNamed(MineWidget.routeName);
                          }
                        : null,
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            color: currentPage == 'mine'
                                ? Color(0xFFFAF5FF)
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(20.0),
                          ),
                          child: Align(
                            alignment: AlignmentDirectional(0.0, 0.0),
                            child: Icon(
                              Icons.person,
                              color: currentPage == 'mine'
                                  ? Color(0xFF9810FA)
                                  : Color(0xFF4A5565),
                              size: 24.0,
                            ),
                          ),
                        ),
                        InkWell(
                          splashColor: Colors.transparent,
                          focusColor: Colors.transparent,
                          hoverColor: Colors.transparent,
                          highlightColor: Colors.transparent,
                          onTap: () async {
                            admob.loadInterstitialAd(
                              "ca-app-pub-3940256099942544/4411468910",
                              "ca-app-pub-3940256099942544/1033173712",
                              true,
                            );
                          },
                          child: Text(
                            FFLocalizations.of(context).getText(
                              'urg50omo' /* Mine */,
                            ),
                            textAlign: TextAlign.center,
                            style: FlutterFlowTheme.of(context).bodySmall.override(
                                  font: GoogleFonts.inter(
                                    fontWeight: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontWeight,
                                    fontStyle: FlutterFlowTheme.of(context)
                                        .bodySmall
                                        .fontStyle,
                                  ),
                                  color: currentPage == 'mine'
                                      ? Color(0xFF9810FA)
                                      : Color(0xFF4A5565),
                                  fontSize: 12.0,
                                  letterSpacing: 0.0,
                                  fontWeight: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontWeight,
                                  fontStyle: FlutterFlowTheme.of(context)
                                      .bodySmall
                                      .fontStyle,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: 60.0,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Padding(
              padding: EdgeInsetsDirectional.fromSTEB(16.0, 8.0, 16.0, 8.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  FlutterFlowAdBanner(
                    width: MediaQuery.sizeOf(context).width * 1.0,
                    height: 50.0,
                    showsTestAd: true,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
