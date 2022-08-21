//
//  TabBAr.swift
//  MovieApp
//
//  Created by Ogabek Bakhodirov on 17/08/22.
//

import UIKit

class TabBarController: UITabBarController{
        
    let popularMoviePage = PopularMovieViewController()
    let upcomingMoviePage = UpComingMovieViewController()
    let topRatedPage = TopRatedViewController()

    override func viewDidLoad() {
        super.viewDidLoad()
        tabBar.tintColor = .white
        tabBar.barTintColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        view.backgroundColor = #colorLiteral(red: 0.05196797848, green: 0.1966994107, blue: 0.3150942922, alpha: 1)
        tabBar.isTranslucent = false
        addTabbarItems()
    }
    
    func addTabbarItems(){
        popularMoviePage.tabBarItem.image = .init(systemName: "flame")
        popularMoviePage.tabBarItem.title = "Popular"
        popularMoviePage.loader = RemoteMovieManager()

        upcomingMoviePage.tabBarItem.image = .init(systemName: "sparkles")
        upcomingMoviePage.tabBarItem.title = "Upcoming"
        upcomingMoviePage.loader = RemoteMovieManager()
        
        topRatedPage.tabBarItem.image = .init(systemName: "crown")
        topRatedPage.tabBarItem.title = "Top Rated"
        topRatedPage.loader = RemoteMovieManager()
        
        viewControllers = [popularMoviePage, upcomingMoviePage, topRatedPage]
        setViewControllers(viewControllers, animated: true)
    }
}
