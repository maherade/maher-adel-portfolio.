import 'package:flutter/material.dart';
import 'package:unping_task/core/utils/responsive.dart';
import 'package:unping_task/core/widgets/scroll_reveal.dart';
import 'package:unping_task/core/widgets/section_header.dart';
import 'package:unping_task/core/models/project_model.dart';
import 'package:unping_task/features/projects/widgets/project_bottom_sheet.dart';
import 'package:unping_task/features/projects/widgets/project_card.dart';
import 'package:unping_task/generated/assets.dart';

class ProjectsSection extends StatelessWidget {
  static final _projects = [
    ProjectModel(
      title: 'BWW Store',
      description:
          'Online Multi-Vendors Store with vendor dashboard, product management, and order tracking.',
      tech: const [
        'Flutter',
        'Firebase',
        'REST APIs',
        'Pusher Notifications',
        'SMS Provider',
        'MVVM',
        'Clean Architecture',
        'Payment Integration',
      ],
      category: 'E-Commerce',
      status: 'Live',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.bwwstore.app&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/eg/app/bww-store/id6753354187',
      coverImage: Assets.imagesBwwIcon,
    ),
    const ProjectModel(
      title: 'GeniePT — AI Personal Trainer',
      description:
          "GeniePT is an AI-powered app that creates personalized workouts for you, tracks your fitness routine, provides articles tailored to your fitness, and provides daily live support."
          "Our goal is to help you achieve your health and fitness goals through a smart app that combines the latest AI technologies with advanced training methods.",
      tech: [
        'Flutter',
        'REST APIs',
        'Cubit',
        'FCM Notifications',
        'Google Sign-In',
        'Apple Sign-In',
        'AI Model',
        'Clean Architecture',
        'Tracking Steps Automatically',
        'Pedometer',
        'Background Service',
        "In-App Purchase",
      ],
      category: 'Health & Fitness',
      status: 'Live',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=com.geniept2.geniept2&pcampaignid=web_share',
      appStoreUrl: 'https://apps.apple.com/eg/app/geniept/id6744561364',
      coverImage: Assets.imagesGenieptImage,
    ),
    const ProjectModel(
      title: 'Nafahat نفحات',
      description:
          'Nafahat is a modern mobile shopping application designed to make discovering and purchasing fragrances simple, enjoyable, and convenient. The app provides users with access to a wide range of perfumes from well-known international brands, allowing them to explore different scents, compare products, and shop directly from their mobile devices.\n\nNafahat enhances the online fragrance shopping experience by combining elegant design with powerful functionality. From discovering new scents to ordering favorite perfumes, the app delivers a smooth and reliable experience that helps users find their perfect fragrance anytime, anywhere.',
      tech: [
        'FCM Notification',
        'REST APIs',
        'Cubit',
        'Clean Architecture',
        'E-Commerce',
      ],
      category: 'E-Commerce',
      status: 'Live',
      playStoreUrl:
          "https://play.google.com/store/apps/details?id=com.async.perfume_store_mobile_app&pcampaignid=web_share",
      appStoreUrl:
          "https://apps.apple.com/sa/app/nafahat-%D9%86%D9%81%D8%AD%D8%A7%D8%AA/id1669749442",
      coverImage: Assets.imagesNafahat,
    ),
    const ProjectModel(
      title: 'Saytara',
      description:
          'Delegate management app for supermarket chains. Streamlines daily workflows and field-rep efficiency.',
      tech: ['Flutter', 'REST APIs', 'Cubit'],
      category: 'Business',
      status: 'Live',
      playStoreUrl:
          'https://play.google.com/store/apps/details?id=darwinz.ai.saytara.saytara&pcampaignid=web_share',
      coverImage: Assets.imagesSaytaraImage,
    ),
    const ProjectModel(
      title: 'Ufeed HR System',
      description:
          'Comprehensive web-based HR management system built with Flutter Flow for employee management and internal operations.',
      tech: ['Flutter Flow', 'Firebase', 'Cloud Functions', "Rest APIs"],
      category: 'Enterprise',
      status: 'Live',
      webUrl: 'https://application.ufeed-ai.com/',
      coverImage: Assets.imagesUfeedLogo,
    ),
  ];

  const ProjectsSection({super.key});

  @override
  Widget build(BuildContext context) {
    final mobile = AppResponsive.isMobile(context);
    final cardWidth = AppResponsive.value<double>(
      context,
      mobile: double.infinity,
      tablet: 360,
      desktop: 420,
    );

    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppResponsive.hPad(context),
        vertical: AppResponsive.vPad(context),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ScrollReveal(
            child: SectionHeader(
              tag: 'PROJECTS',
              title: "Things I've built",
              subtitle: 'A selection of apps shipped to real users.',
            ),
          ),
          const SizedBox(height: 50),
          mobile
              ? Column(
                  children: List.generate(
                    _projects.length,
                    (index) => Padding(
                      padding: const EdgeInsets.only(bottom: 20),
                      child: ProjectCard(
                        project: _projects[index],
                        onTap: () => _showDetails(context, _projects[index]),
                      ),
                    ),
                  ),
                )
              : Wrap(
                  spacing: 22,
                  runSpacing: 22,
                  children: List.generate(
                    _projects.length,
                    (index) => TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.0, end: 1.0),
                      duration: Duration(milliseconds: 500 + (index * 120)),
                      curve: Curves.easeOut,
                      builder: (_, value, child) => Opacity(
                        opacity: value,
                        child: Transform.translate(
                          offset: Offset(0, 20 * (1 - value)),
                          child: child,
                        ),
                      ),
                      child: SizedBox(
                        width: cardWidth,
                        child: ProjectCard(
                          project: _projects[index],
                          onTap: () => _showDetails(context, _projects[index]),
                        ),
                      ),
                    ),
                  ),
                ),
        ],
      ),
    );
  }

  void _showDetails(BuildContext context, ProjectModel project) {
    showDialog(
      context: context,
      barrierColor: Colors.black.withValues(alpha: 0.6),
      builder: (_) => ProjectDialog(project: project),
    );
  }
}
