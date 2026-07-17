import 'dart:async';

import 'package:employee_support_system/core/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnimation;
  late final Animation<double> _fadeAnimation;

  @override 
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );

    _scaleAnimation = Tween<double>(
      begin: .8,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOutBack));

    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);

    _controller.forward();

    Timer(const Duration(seconds: 3), () {
      final SupabaseClient client = Supabase.instance.client;
      if (client.auth.currentSession == null) {
        Navigator.of(context).pushNamed(Routes.login);
      } else {
        Navigator.of(context).pushNamed(Routes.home);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xff3B82F6);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          /// Top Left
          Positioned(
            top: -80,
            left: -80,
            child: Container(
              width: 220,
              height: 220,
              decoration: BoxDecoration(
                color: primary.withOpacity(.12),
                shape: BoxShape.circle,
              ),
            ),
          ),

          /// Bottom Right
          Positioned(
            bottom: -90,
            right: -90,
            child: Container(
              width: 240,
              height: 240,
              decoration: BoxDecoration(
                color: primary.withOpacity(.12),
                shape: BoxShape.circle,
              ),
            ),
          ),

          Center(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: ScaleTransition(
                scale: _scaleAnimation,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 120,
                      height: 120,
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(32),
                      ),
                      child: const Icon(
                        Icons.support_agent,
                        color: Colors.white,
                        size: 70,
                      ),
                    ),

                    const SizedBox(height: 30),

                    RichText(
                      text: const TextSpan(
                        style: TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.bold,
                        ),
                        children: [
                          TextSpan(
                            text: "Help",
                            style: TextStyle(color: Colors.black87),
                          ),
                          TextSpan(
                            text: "Desk",
                            style: TextStyle(color: primary),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "We're here to help",
                      style: TextStyle(fontSize: 18, color: Colors.grey),
                    ),

                    const SizedBox(height: 50),

                    const SizedBox(
                      width: 35,
                      height: 35,
                      child: CircularProgressIndicator(
                        color: primary,
                        strokeWidth: 3,
                      ),
                    ),

                    const SizedBox(height: 14),

                    const Text(
                      "Loading...",
                      style: TextStyle(color: Colors.grey, fontSize: 15),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
