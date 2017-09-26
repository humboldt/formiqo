<template>
  <div id="app">
    <p>{{ message }}</p>
    <chart :labels="labels" :data="data" :loaded="loaded" type="bar"></chart>
  </div>
</template>

<script>

import Chart from './chart.vue'
export default {
  data: function () {
    return {
      message: "Today's mailbox activity",
      labels: [],
      data: [],
      loaded: false
    }
  },
  methods: {
    fetchData: function() {
      this.$http.get('/admin/fetch_data').then(res => {
        this.labels = res.body[0];
        this.data = res.body[1];
        this.loaded = true;
      })
    }
  },
  created() {
    this.fetchData()
  },
  components: {Chart}
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
