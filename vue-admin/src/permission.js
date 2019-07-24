import router from './router'
import store from './store'
import NProgress from 'nprogress' // Progress progress bar
import 'nprogress/nprogress.css'// Progress progress bar style
import { Message } from 'element-ui'
import { getToken } from '@/utils/auth' // Authentification

const whiteList = ['/login'] // Do not redirect whitelist
router.beforeEach((to, from, next) => {
  NProgress.start()
  if (getToken()) {
    if (to.path === '/login') {
      next({ path: '/' })
      NProgress.done() // if current page is dashboard will not trigger	afterEach hook, so manually handle it
    } else {
      if (store.getters.menus.length === 0) {
        // Pull user information (make sure the menu list has been obtained in the GetInfo method)
        store.dispatch('GetInfo').then(res => {
          // Dynamically set the route (pass the user obtained in the previous step to the GenerateRoutes method to resolve)
          store.dispatch('GenerateRoutes', store.getters.menus).then(r => {
            // Get the list of routes that have been resolved and dynamically add them to the router.
            router.addRoutes(store.getters.dynamicRouters)

            // Hack method to ensure that addRoutes is complete
            next({ ...to, replace: true }) // set the replace: true so the navigation will not leave a history record
          })
        }).catch((err) => {
          store.dispatch('FedLogOut').then(() => {
            Message.error(err || 'Verification failed, please login again')
            next({ path: '/' })
          })
        })
      } else {
        next()
      }
    }
  } else {
    if (whiteList.indexOf(to.path) !== -1) {
      next()
    } else {
      next(`/login?redirect=${to.path}`) // Otherwise redirect all to the login page
      NProgress.done()
    }
  }
})

router.afterEach(() => {
  NProgress.done() // End Progress
})
