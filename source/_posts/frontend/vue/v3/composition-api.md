title: 使用@vue/composition-api
date: 2020-06-23 17:26:59
tags:
categories:
 - 前端
 - vue
 - v3 - composition-api
---

# 构建

## 前言

<p>之所以使用@vue/composition-api而非直接使用v3，考虑到ui库目前能支持的都只是2.0的版本。</p>

> 构建项目

vue-cli构建常规vue项目后
``` 
 yarn add @vue/composition-api // 引包
```
在main.js中
``` 
import VueCompositionApi from '@vue/composition-api'

Vue.use(VueCompositionApi)
```

> 注意点

- 由于composition-api还在不断更新当中，所以有时候在我们更新完之后，在node_modules里面会产生两个@vue/composition-api的库，需要删除旧的才能正确引用，
或者<kbd>rm-rf node_modules</kbd>删除掉node-modules后重新 install. 参考[issue](https://github.com/vuejs/composition-api/issues/228)

> 小结

基本的在官方的网站上都有，这里就不多举例了。只列举一些常见但我自己没有找到的，后续会继续补充

- this对象
```
 import { getCurrentInstance } from '@vue/composition-api'
 export default {
   setup (props, context) {
     const ctx = getCurrentInstance // @vue/composition-api里面，这里我们使用这个
     // const { ctx } = getCurrentInstance // vue3里面
   }
 }
```

- $router
``` 
  ctx.$router.push({ name: 'root' }) // 没多大变化，可以在this(ctx)中里面取或者在context中取也可以（context.root.$router）
```
- vuex
个人喜欢将vuex分modules去写，这样清楚，所以我是开启了namespaced的。在setup中使用时跟vue2一样
```
import { reactive } from '@vue/composition-api'
import { createNamespacedHelpers } from 'vuex'
const { mapActions } = createNamespacedHelpers('app') 
export default {
  setup () {
    // methods
    const state = reactive({
      form: {
        userName: '',
        password: ''
      }
    })
    const Login = () => {
      loginRequest().then(({success, msg, data: { menuList }}) => {
        if (success) {
          ctx.setMenuList(menuList) // 通过ctx.调用mapActions解构出来的方法
        }
      })
    }
    return {
      ...mapActions(['setMenuList']) // 直接解构后返回出去就可以了
    }
  }
}
```
