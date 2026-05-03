import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../bloc/news_event.dart';
import '../../bloc/news_bloc.dart';
import '../../bloc/news_state.dart';

class NewsScreen extends StatefulWidget {
  const NewsScreen({super.key});

  @override
  State<NewsScreen> createState() => _NewsScreenState();
}

class _NewsScreenState extends State<NewsScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Load REST API news by default
    context.read<NewsBloc>().add(LoadNews());
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tech News'),
        centerTitle: true,
        bottom: TabBar(
          controller: _tabController,
          indicatorColor: Colors.red,
          tabs: const [
            Tab(text: 'Latest News', icon: Icon(Icons.newspaper)),
            Tab(text: 'Gemini Summary', icon: Icon(Icons.smart_toy)),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          // TAB 1: REST API News
          _buildRestApiNewsTab(),
          // TAB 2: Gemini Summary
          _buildGeminiSummaryTab(),
        ],
      ),
    );
  }

  /// TAB 1: REST API News (Existing functionality)
  Widget _buildRestApiNewsTab() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is NewsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is NewsLoaded) {
          return ListView.builder(
            itemCount: state.news.length,
            itemBuilder: (context, index) {
              final newsItem = state.news[index];
              return Card(
                margin: const EdgeInsets.all(8),
                child: ListTile(
                  title: Text(newsItem.headline),
                  subtitle: Text(newsItem.body),
                  isThreeLine: true,
                  trailing: IconButton(
                    icon: const Icon(Icons.refresh),
                    onPressed: () {
                      context.read<NewsBloc>().add(LoadNews());
                    },
                  ),
                ),
              );
            },
          );
        } else if (state is NewsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text('Error: ${state.message}', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<NewsBloc>().add(LoadNews());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return Center(
          child: ElevatedButton(
            onPressed: () {
              context.read<NewsBloc>().add(LoadNews());
            },
            child: const Text('Load News'),
          ),
        );
      },
    );
  }

  /// TAB 2: Gemini AI Summary (New functionality)
  Widget _buildGeminiSummaryTab() {
    return BlocBuilder<NewsBloc, NewsState>(
      builder: (context, state) {
        if (state is GeminiLoading) {
          return const Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CircularProgressIndicator(),
                SizedBox(height: 16),
                Text('Getting AI-curated summary...'),
              ],
            ),
          );
        } else if (state is GeminiLoaded) {
          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.smart_toy, color: Colors.lime),
                            const SizedBox(width: 8),
                            Text(
                              'Gemini AI Curated Summary',
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ],
                        ),
                        const Divider(),
                        const SizedBox(height: 12),
                        Text(state.summary),
                        const SizedBox(height: 16),
                        Align(
                          child: ElevatedButton.icon(
                            onPressed: () {
                              context.read<NewsBloc>().add(LoadGeminiSummary());
                            },
                            icon: const Icon(Icons.refresh),
                            label: const Text('Refresh Summary'),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Text(
                  'Note: Summary is generated using Google Generative AI (Gemini) with real-time web search, in Pakistani Korangi slang Roman Urdu.',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
              ],
            ),
          );
        } else if (state is NewsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, color: Colors.red, size: 48),
                const SizedBox(height: 16),
                Text('Error: ${state.message}', textAlign: TextAlign.center),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<NewsBloc>().add(LoadGeminiSummary());
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }
        return Center(
          child: ElevatedButton.icon(
            onPressed: () {
              context.read<NewsBloc>().add(LoadGeminiSummary());
            },
            icon: const Icon(Icons.smart_toy),
            label: const Text('Get AI Summary'),
          ),
        );
      },
    );
  }
}
