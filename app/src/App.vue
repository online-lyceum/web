<template>
    <div id="App">
        <select-subgroup @select="selectingSubgroup" />
        <lesson-list :subgroup_id="subgroup_id" />
    </div>
</template>

<script>
import SelectSubgroup from "@/components/SelectSubgroup"
import LessonList from "@/components/LessonList"

export default {
  name: 'App',
  data() {
    return {
        subgroup_id: undefined 
    }
  },
  components: {
    SelectSubgroup,
    LessonList
  },
  methods: {
    selectingSubgroup(subgroup_id) {
        this.subgroup_id = subgroup_id
    }
  }
}
</script>

<style>
#App {
    padding: 20px;
}
</style>
