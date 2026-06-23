import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../theme/app_theme.dart';

class QaNews {
  final String title;
  final String summary;
  final String source;

  const QaNews({
    required this.title,
    required this.summary,
    required this.source,
  });
}

const _newsItems = [
  QaNews(
    title: 'Selenium 5.0 oficjalnie wydany',
    summary:
        'Nowa wersja frameworka z ulepszonym WebDriverem, natywną obsługą shadow DOM oraz szybszym WebDriver BiDi.',
    source: 'Sauce Labs Blog',
  ),
  QaNews(
    title: 'Playwright przejmuje rynek E2E',
    summary:
        'Raport 2025 pokazuje 40% wzrost adopcji Playwright wśród zespołów QA, wyprzedzając Cypress i Selenium.',
    source: 'State of JS / Testing',
  ),
  QaNews(
    title: 'AI generuje 75% przypadków testowych',
    summary:
        'Nowe narzędzia oparte na LLM osiągają 85% pokrycia kodu w projektach pilotażowych największych firm.',
    source: 'Gartner QA Trends',
  ),
];

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GreetingSection(),
          const SizedBox(height: 24),
          _QaIllustration(),
          const SizedBox(height: 28),
          Text(
            'Wczoraj w świecie QA',
            style: GoogleFonts.getFont('Young Serif',
              fontSize: 22, fontWeight: FontWeight.w700,
              color: AppColors.foreground),
          ),
          const SizedBox(height: 8),
          Text(
            'Najważniejsze wydarzenia z poprzedniego dnia',
            style: TextStyle(fontSize: 13, color: AppColors.secondary),
          ),
          const SizedBox(height: 16),
          ..._newsItems.map((news) => _NewsCard(news: news)),
        ],
      ),
    );
  }
}

class _GreetingSection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Hi, QA Tester',
          style: GoogleFonts.getFont('Young Serif',
            fontSize: 28, fontWeight: FontWeight.w700,
            color: AppColors.foreground),
        ),
        const SizedBox(height: 4),
        Text(
          'Co dziś testujemy?',
          style: TextStyle(fontSize: 15, color: AppColors.secondary),
        ),
      ],
    );
  }
}

class _QaIllustration extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 160,
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppColors.roughCard,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.2)),
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // decorative circles
          Positioned(
            top: -20,
            right: -10,
            child: _decorationCircle(AppColors.primary.withValues(alpha: 0.12), 100),
          ),
          Positioned(
            bottom: -30,
            left: -20,
            child: _decorationCircle(AppColors.accent.withValues(alpha: 0.06), 130),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.bug_report, size: 48, color: AppColors.primary),
              const SizedBox(width: 24),
              Icon(Icons.check_circle_outline, size: 40, color: AppColors.correct),
              const SizedBox(width: 24),
              Icon(Icons.terminal, size: 42, color: AppColors.accent),
            ],
          ),
        ],
      ),
    );
  }

  Widget _decorationCircle(Color color, double size) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: color,
      ),
    );
  }
}

class _NewsCard extends StatelessWidget {
  final QaNews news;

  const _NewsCard({required this.news});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: AppColors.roughCard,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: AppColors.secondary.withValues(alpha: 0.15)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 2),
                width: 4,
                height: 18,
                decoration: BoxDecoration(
                  color: AppColors.primary,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  news.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    color: AppColors.foreground,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              news.summary,
              style: TextStyle(fontSize: 13, color: AppColors.foreground.withValues(alpha: 0.7)),
            ),
          ),
          const SizedBox(height: 6),
          Padding(
            padding: const EdgeInsets.only(left: 16),
            child: Text(
              news.source,
              style: const TextStyle(fontSize: 11, color: AppColors.secondary),
            ),
          ),
        ],
      ),
    );
  }
}
