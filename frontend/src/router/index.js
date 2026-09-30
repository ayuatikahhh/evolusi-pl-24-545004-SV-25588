import { createRouter, createWebHistory } from 'vue-router'
import Home from '../views/Home.vue'
import PresetList from '../views/PresetList.vue'

const router = createRouter({
  history: createWebHistory(import.meta.env.BASE_URL),
  routes: [
    { path: '/', name: 'home', component: Home },
    { path: '/presets', name: 'presets', component: PresetList },
  ],
})

export default router