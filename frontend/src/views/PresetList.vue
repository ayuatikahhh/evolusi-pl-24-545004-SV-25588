<script setup>
import { ref, onMounted } from 'vue'
import { formatRatioLabel, isValidPreset } from '../utils/presetHelper'

const presetList = ref([])
const isLoading = ref(true)
const errorMessage = ref('')

const apiUrl = import.meta.env.VITE_API_URL

onMounted(async () => {
  try {
    const res = await fetch(`${apiUrl}/presets`)
    const json = await res.json()
    presetList.value = json.data
  } catch (e) {
    errorMessage.value = 'Gagal mengambil data dari server.'
  } finally {
    isLoading.value = false
  }
})
</script>

<template>
  <main>
    <h1>Preset Rasio Alokasi</h1>
    <p v-if="isLoading">Memuat data...</p>
    <p v-else-if="errorMessage">{{ errorMessage }}</p>
    <ul v-else>
      <li v-for="preset in presetList" :key="preset.id">
        <strong>{{ preset.name }}</strong> — {{ formatRatioLabel(preset) }}
        <span v-if="isValidPreset(preset)"> (✓ total 100%)</span>
      </li>
    </ul>
    <router-link to="/">← Kembali</router-link>
  </main>
</template>