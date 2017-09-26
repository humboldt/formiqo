<template lang="html">
  <canvas style="width: 512px; height: 256px" ></canvas>
</template>

<script>
import Chart from 'Chart.bundle.min'
export default {
  props: ['labels', 'data', 'type', 'loaded'],
  watch: {
    loaded: function(isLoaded){
      if(isLoaded){
        this.drawChart();
      }
    }
  },
  methods: {
    drawChart: function() {
      new Chart(this.$el, {
        type: this.type,
        data: {
            labels: this.labels,
            datasets: [{
                label: '# Mailbox activity',
                data: this.data,
                backgroundColor: [
                  'rgba(255, 99, 132, 0.6)',
                  'rgba(54, 162, 235, 0.6)',
                  'rgba(255, 206, 86, 0.6)',
                  'rgba(75, 192, 192, 0.6)',
                  'rgba(153, 102, 255, 0.6)',
                  'rgba(255, 159, 64, 0.6)'
                ],
                borderColor: [
                  'rgba(255,99,132,1)',
                  'rgba(54, 162, 235, 1)',
                  'rgba(255, 206, 86, 1)',
                  'rgba(75, 192, 192, 1)',
                  'rgba(153, 102, 255, 1)',
                  'rgba(255, 159, 64, 1)'
                ],
                borderWidth: 1
            }]
        },
        options: {
            scales: {
                yAxes: [{
                    ticks: {
                        beginAtZero:true
                    }
                }]
            }
          }
        })
    }
  }
}
</script>

<style lang="css">
</style>
