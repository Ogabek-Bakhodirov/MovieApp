//
//  TabBAr.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 17/08/22.
//

import UIKit

class TabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.barTintColor = .white
        tabBar.tintColor = .white
        tabBar.backgroundColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        view.backgroundColor = .systemGray6
        addTabbarItems()
    }
    
    func addTabbarItems(){
        let popularMoviePage = PopularMovieViewController()
        popularMoviePage.tabBarItem.image = .init(systemName: "flame")
        popularMoviePage.tabBarItem.title = "Popular"
        typeURL.popular.rawValue
        popularMoviePage.loader = RemoteMovieManager()
        
        let upcomingMoviePage = UpComingMovieViewController()
        upcomingMoviePage.tabBarItem.image = .init(systemName: "sparkles")
        upcomingMoviePage.tabBarItem.title = "Upcoming"
//        MovieTypeURL.url = typeURL.upcoming.rawValue
        upcomingMoviePage.loader = RemoteMovieManager()
        
        let topRatedPage = TopRatedViewController()
        topRatedPage.tabBarItem.image = .init(systemName: "crown")
        topRatedPage.tabBarItem.title = "Top Rated"
//        typeURL.topRated
//        topRatedPage.loader = RemoteMovieManager()

        viewControllers = [popularMoviePage, upcomingMoviePage, topRatedPage]
        setViewControllers(viewControllers, animated: true)
    }
}
