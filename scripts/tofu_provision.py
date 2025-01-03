import utils
import tofu_plan
import tofu_apply


if __name__ == '__main__':
    config = utils.TofuFig()

    tofu_plan.run(config)
    tofu_apply.run(config)